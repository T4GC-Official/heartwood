# Heartwood: Information Architecture Plan

Heartwood is the meta-architecture and orientation hub for the Good Shepherd ecosystem.
It is the starting point for new team members and for agents working across multiple repos.

This PLAN.md is a working document. Process each part sequentially with the user,
discuss before making changes, and update this file as decisions are made.

---

## How to use this plan

Work through Parts 1-6 in order. For each part:
1. Read the section aloud/summarize to the user
2. Ask if they want to adjust anything before implementing
3. Implement
4. Mark the part DONE and note any deviations

---

## Part 1: Repo skeleton + AGENTS.md

Goal: Create the top-level directory structure and the entry-point AGENTS.md.

### Directories to create

```
heartwood/
  AGENTS.md
  .agent/
    rules/
      ecosystem-map.md         <- stub, filled in Part 2
      arch-principles.md       <- stub, filled in Part 3
      doc-placement-guide.md   <- stub, filled in Part 4
      agent-guide.md           <- stub, filled in Part 4
  docs/
    arch/
      system-overview.md       <- stub
      cross-app-auth.md        <- stub
      graduation-framework.md  <- stub, filled in Part 5
    how-to/
      onboard-new-component.md <- stub, filled in Part 6
      graduate-a-poc.md        <- stub, filled in Part 5
    tutorials/
      new-hire-start-here.md   <- stub
  repos/                       <- .gitignored, populated by setup.sh
  setup.sh                     <- stub, filled as repos are confirmed
```

### AGENTS.md content

This file should be short. Agents read it first. It must orient without overwhelming.

```
# Heartwood

You are in the Heartwood repo, the meta-architecture hub for the Good Shepherd ecosystem.

## What this is

Heartwood documents cross-repo architecture, component relationships, and the
philosophy for how components evolve and interact. It does NOT contain component
code or component-specific standards.

## Quick start for agents

1. Read .agent/rules/ecosystem-map.md to see all components and their current status
2. Read .agent/rules/arch-principles.md for design philosophy
3. For cross-repo navigation tasks, read .agent/rules/agent-guide.md
4. All repos are cloned to ./repos/ via setup.sh (run it if repos/ is empty)

## What NOT to look for here

Component-specific schemas, standards, pipelines, and API contracts live in
each component's own repo. The ecosystem-map will point you to the right place.
```

### Status: TODO

---

## Part 2: ecosystem-map.md

Goal: Document all repos, their purpose, status, and relationships.

The user will provide the list of external repos and their paths during this step.

### Content to fill in

For each repo, record:
- Name and location (filesystem path + git URL)
- One-line purpose
- Current graduation stage (see Part 5 for stage definitions)
- Primary contract/interface (API endpoint, output file, etc.)
- Relationship to other repos (produces data for X, authenticates via Y, etc.)

### Format (simple table)

```
| Repo            | Path                        | Stage | Purpose                        | Key interface              |
|---              |---                          |---    |---                             |---                         |
| good-shepherd   | repos/good-shepherd         | POC   | POC hub + server               | server/README.md           |
| heartwood       | .                           | POC   | Architecture + orientation     | this file                  |
| (others TBD)    | repos/<name>                | ?     | (user to fill in)              | ?                          |
```

### Status: TODO - user to provide repo list and paths

---

## Part 3: arch-principles.md

Goal: Document the "why" behind architectural decisions. This is the Explanation
layer (Diataxis). It should be durable and not repeat information in other docs.

### Topics to cover (draft, user to confirm)

- What is Good Shepherd trying to be (1 paragraph)
- The POC-first philosophy: build fast, validate in field, then stabilize
- How components communicate: API-first, schemas as contracts
- Technology preferences: Python backend, Vue3/HTML frontend, FastAPI, Frappe
- Coordinate system default: EPSG:4326
- Auth model: Cognito JWT enforced at API Gateway, not in application code
- Data residency and S3 conventions
- When to add a new repo vs a new component in an existing repo

### Status: TODO

---

## Part 4: doc-placement-guide.md + agent-guide.md

Goal: Define the rules for where documentation lives. This prevents duplication
and confusion about whether something belongs in heartwood or in a component repo.

### doc-placement-guide.md decision rules

```
Question: Does this doc describe something that spans 2+ repos or components?
  YES -> Put it in heartwood/docs/arch/
  NO  -> Put it in the component's own docs/

Question: Is this a schema or contract for a specific data format?
  YES -> Put it in <component>/standards/ with a .schema.json or .md file
  NO  -> Continue

Question: Is this a pipeline (input -> transform -> output) for a specific component?
  YES -> Put it in <component>/pipeline.md
  NO  -> Continue

Question: Is this a runbook for operating or deploying a specific component?
  YES -> Put it in <component>/docs/how-to/
  NO  -> If it spans components, put it in heartwood/docs/how-to/

Question: Is this orientation material for understanding the whole ecosystem?
  YES -> Put it in heartwood/docs/tutorials/ or heartwood/docs/arch/
```

### agent-guide.md content

Instructions for agents on how to navigate this ecosystem efficiently:
- Start in heartwood when the task spans repos
- Start in the component repo when the task is component-specific
- Use ecosystem-map.md as the index, not file search
- Each repo follows the same internal structure (listed below)
- Do not load all repos into context; navigate to the relevant one

Per-repo standard structure (what agents should expect in any repo):
```
<repo>/
  AGENTS.md            <- thin entry point
  .agent/rules/        <- detailed agent context
  STATUS.md            <- graduation stage
  <component>/
    standards/         <- schemas and contracts
    pipeline.md        <- data flow description
    outputs.md         <- what this produces
    docs/
      architecture/    <- component-internal design (not cross-repo)
```

### Status: TODO

---

## Part 5: graduation-framework.md + graduate-a-poc.md

Goal: Define what it means for a component to move from POC to stable,
and document the process for doing so.

### Stage definitions

```
Stage 0 - Concept POC
  - Code lives in examples/ or equivalent
  - No real users, internal only
  - No deployment requirement
  - Criteria to advance: working demo, basic contract documented

Stage 1 - Field POC
  - Deployed to a real environment (not just localhost)
  - At least 1 real user observed using it in field conditions
  - Known issues documented in STATUS.md
  - Criteria to advance: issues from field observation fixed, pipeline.md written

Stage 2 - Early Access
  - At least 2 users
  - Basic monitoring/logging in place
  - API contract documented in standards/ or server/README.md
  - Criteria to advance: stable for 1 field season, no owner-dependency for ops

Stage 3 - Stable
  - Documented API (standards/ + pipeline.md complete)
  - Tests covering key contracts
  - Deployment is repeatable without the original author
  - heartwood ecosystem-map updated with stable status
```

### graduation checklist (for graduate-a-poc.md)

1. Write or update pipeline.md for the component
2. Write or update standards/ schemas for all data contracts
3. Update STATUS.md with new stage and date
4. Update heartwood ecosystem-map.md
5. If moving out of examples/: update good-shepherd AGENTS.md to remove the component pointer

### Status: TODO

---

## Part 6: onboard-new-component.md + per-repo AGENTS.md template

Goal: Define what a new component needs when it is first created, so all repos
follow the same convention.

### New component checklist

When adding a new POC to examples/ or creating a new repo:

1. Create AGENTS.md using the template below
2. Create .agent/rules/project-context.md (copy from another component and adapt)
3. Create STATUS.md with Stage 0
4. Create standards/ directory (can be empty stub)
5. Create pipeline.md (can be stub with "inputs: TBD, outputs: TBD")
6. Create outputs.md
7. Add to heartwood ecosystem-map.md

### AGENTS.md template for individual repos/components

```
# <Component Name>

**Status:** See STATUS.md

## What this is

(2-3 sentences describing what this component does and who uses it.)

## Where to find things

- Detailed agent context: .agent/rules/project-context.md
- Data contracts and schemas: <path>/standards/
- Data pipeline (inputs -> outputs): <path>/pipeline.md
- API documentation: <path>/docs/api.md  (or server/README.md for the shared server)
- Current known issues: STATUS.md

## System context

This component is part of the Good Shepherd ecosystem.
For cross-repo architecture and component relationships, see the Heartwood repo.
```

### Status: TODO

---

## Part 7: setup.sh

Goal: A script that clones all repos to ./repos/ so relative paths work for agents.

This part depends on Part 2 (ecosystem-map) being complete, since the list of repos
is not finalized until the user provides it.

### Rough structure

```bash
#!/bin/bash
# setup.sh - Clone all Good Shepherd ecosystem repos into ./repos/
# Run this once after cloning heartwood.

WORKSPACE="$(cd "$(dirname "$0")" && pwd)/repos"
mkdir -p "$WORKSPACE"

# Add each repo here as they are confirmed
# git clone git@github.com:org/good-shepherd.git "$WORKSPACE/good-shepherd"
# git clone git@github.com:org/nursery-db.git "$WORKSPACE/nursery-db"

echo "Done. Repos cloned to $WORKSPACE"
```

Repos/ is .gitignored. The script is idempotent (skip clone if dir exists).

### Status: TODO - repo list TBD in Part 2

---

## Documentation framework reference (Diataxis + extensions)

This ecosystem uses an extended version of the Diataxis framework:

```
Type       | Purpose                        | Location
---        | ---                            | ---
Tutorial   | Learning, new hire walkthrough | heartwood/docs/tutorials/
How-to     | Task runbooks                  | heartwood/docs/how-to/ or <repo>/docs/how-to/
Reference  | Schemas, API specs, lookups    | <repo>/standards/, server/README.md
Explanation| Design rationale, why          | heartwood/docs/arch/ (cross-repo) or <repo>/docs/arch/ (component)
Pipeline   | Data flow contracts            | <repo>/pipeline.md per component (Good Shepherd extension)
Agent      | Agent orientation              | AGENTS.md + .agent/rules/ in each repo (Good Shepherd extension)
```

Rule of thumb: if it crosses repo boundaries, it lives in heartwood. If it is
specific to one component, it lives in that component.
