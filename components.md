# Components 

1. fomomon flutter field app and admin panel 
	path: /home/desinotorious/src/github.com/bprashanth/fomomon
2. fomo vue3 web app
	path: /home/desinotorious/src/github.com/bprashanth/cc/fomo 
3. form-idable paper form extraction app 
	path: /home/desinotorious/src/github.com/bprashanth/form-idable
4. good-shepherd pocs and API server 
	path: /home/desinotorious/src/github.com/bprashanth/good-shepherd
	- nursery
	- ...see desription in good-shepherd AGENTS and .agents 
5. plantwise / alienwise 
	path: /home/desinotorious/src/github.com/bprashanth/plantwise/PlantWise
6. dlt drone lantana detection pipeline 
	you can just mention this, it isn't integrated into the pipeline of the dss (https://github.com/bprashanth/dlt)


## Goals 

1. Define the desired structure of each component - these should be similar to what's described in good-shepherd's .agents, it should be documented here even if all components don't have this structure. We can use a per repo agent to fill in the blanks. 
...
2. agent and human navigation must be clear and not verbose. Docs should be created using human editable simple ascii. 
3. Clearly document the stages to creating a new poc 4
4. Clearly document the stages and steps for graduating a poc to a stable state 
5. A framework for keeping this repo up to date. 

### Architecture docs 

1. Define the architecture. 
2. Define pieces that span and touch multiple components. 
3. Define or explain how components might communicate with each other: specifically, phone to web, web to alienwise etc. Currently there is a s3 storage backend, a server (the servreless component) an admin panel. Currently the pattern is user captures some data in field, standardizes/cleans it on dashboard, these standards are mentioned in standards/ and then it's added to some s3 bucket and/or a db backend. Depending on the component, the specifics might be slightly different. 

You will need to understand the integrations and take inspiration from the sub-repo docs files to do this, eg /home/desinotorious/src/github.com/bprashanth/good-shepherd/server/docs/manuals/cross_app_auth.md

### Setup

write the setup script to pull the repo to ./repos 
But before writing the setup script ask for permissions and the actual link the the repo. 

### migration 

Once we have documented things as they stand we will discuss migrating the repos from github.com/bprashanth to github.com/T4GC-Official/ 


