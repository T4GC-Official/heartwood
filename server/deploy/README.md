# POC Server Deploy Template

Deploys a FastAPI server as an AWS Lambda Function URL — no API Gateway,
no auth middleware. Cost protection via reserved concurrency + budget alert.

## Quickstart

1. Copy this `deploy/` directory into your POC's server directory
2. Edit **`config.sh`** — the only file you need to touch
3. Add a `Dockerfile` to your server directory (see template below)
4. Run once to create AWS infra:
   ```bash
   ./deploy/setup.sh
   ```
5. Deploy (and on every subsequent change):
   ```bash
   ./deploy/deploy.sh
   ```
6. Paste the printed `[[redirects]]` block into your `netlify.toml`

---

## Minimum Dockerfile

```dockerfile
FROM public.ecr.aws/docker/library/python:3.12-slim
COPY --from=public.ecr.aws/awsguru/aws-lambda-adapter:0.9.1 \
     /lambda-adapter /opt/extensions/lambda-adapter
# PORT and HEALTH_CHECK_PATH must match values in config.sh
ENV PORT=8070 AWS_LWA_PORT=8070 \
    AWS_LWA_READINESS_CHECK_PATH=/health
WORKDIR /var/task
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8070"]
```

Your server must expose `GET <HEALTH_CHECK_PATH>` returning HTTP 200.
Lambda Web Adapter polls it before marking the function ready.

---

## Cost protection

**Reserved concurrency** (`RESERVED_CONCURRENCY` in config.sh) is a hard per-function
cap on simultaneous executions. A bot hammering the endpoint gets 429s above that
limit. With 10 concurrent executions and 512MB memory, the absolute worst-case
monthly cost is ~$3 (for this function only).

**Budget alert** (`BUDGET_LIMIT_USD`) fires an email at 80% of the threshold.
It covers **all Lambda functions in the account** — set it high enough not to
false-fire from other functions (e.g. good-shepherd). $10 is a safe default.

---

## Dev / prod routing

In **dev**, Vite proxy handles routing (no PWA code changes needed):
```js
// vite.config.js  →  server.proxy
'/your-prefix': 'http://localhost:8071'
```

In **prod**, Netlify redirects handle it (paste from `deploy.sh` output):
```toml
# netlify.toml
[[redirects]]
  from = "/your-prefix/*"
  to = "https://<id>.lambda-url.<region>.on.aws/your-prefix/:splat"
  status = 200
  force = true
```

The PWA always uses relative paths — only the proxy layer changes between environments.

---

## Files

| File | Edit? | Purpose |
|---|---|---|
| `config.sh` | **Yes** | All variables |
| `setup.sh` | No | One-time: ECR, IAM role, budget alert |
| `build.sh` | No | Docker build + smoke test |
| `push.sh` | No | ECR push + Lambda create/update + Function URL |
| `deploy.sh` | No | Orchestrator: build → test → push |
| `lambda-policy.json` | Maybe | CloudWatch logs; add S3/Textract if needed |
| `trust-policy.json` | No | Standard Lambda assume-role |
