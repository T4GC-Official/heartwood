# How to Onboard a New Component

> Status: STUB -- to be filled in Part 6

Checklist and instructions for adding a new POC or repo to the Good Shepherd ecosystem.

See also: .agent/rules/agent-guide.md for the expected repo structure.

## API servers 

It is often desirable (and easy) to use an apiserver in your poc. This cleanly separates client and server logic. However it also begs the question: how do we host it? Till now, the approach we have taken is through an AWS lambda service, and this is for a few different reasons: 

1. It's ratelimitable, so we can mitigate the low chance of a ddos attack without another gateaway
2. It has a free tier 
3. Since we don't know whether a POC will actually make it to good-shepherd, it doesn't make sense to keep risking the disruption of stable good-shepherd apis as we iterate and plan out ad-hoc features

So if your poc requires a server, use these steps.

First let's discuss the division of labor. What _should_ go into the good-shepherd server, even for a poc:     

1. If your API needs any kind of specia auth, eg, if it calls aws services, it must go behind a api gateway. We expect this to be a minority of services. 
2. If the API is pure "logic", then it doesn't really need auth. It just needs a [rate limit](#rate_limiting_the_poc_server). 
3. If it's a combination, have the frontend take auth credentials, auth with cognito/auth providers, send those credentials to the gateway protected good-shepherd server that calls aws, and call the poc server for everything else. 

In other words, only the gateway protected good-shepherd server should speak with aws to avoid "denial of wallet". 

Now we can discuss the hosting of pure logic api servers. These are servers that say, perform a dictionary lookup, or fetch map tiles. 

1. Copy and modify the templatized setup scripts in `heartwood/server/deploy` into your server's directory (see [deploy/README](../server/deploy/README.md)).
2. Regarding dev vs prod

In dev, the Vite proxy handles both (assuming your endpoints are `/agent` in both dev and prod:
- `/api/*` -> good-shepherd (or localhost equivalent)                                          
- `/agent/*` -> localhost:8071   

In prod, Netlify redirects handle both, no code changes needed in your frontend:
```console 
# netlify.toml                                                                              
[[redirects]] 
  from = "/agent/*"                                                                         
  to = "https://<agent-apigw>.execute-api.ap-south-1.amazonaws.com/prod/agent/:splat"     
  status = 200                                                                              
  force = true  
```
Where `agent-apigw` is the name returned from the `deploy` step. 

### Rate limiting the poc server 

The deploy scripts set `ReservedConcurrentExecutions = 10` on the Lambda function. This hard-caps how many instances run simultaneously. 
Cost math at worst case (10 concurrent, 1-second requests, 512MB):                                                   
- 10 × 86,400 seconds/day = 864,000 req/day theoretical max
- Lambda pricing: ~$0.17/day = ~$5/month absolute ceiling

The scripts also set a lambda alert for 3$ billing so we're notified of this.
