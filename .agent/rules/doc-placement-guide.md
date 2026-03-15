# Doc Placement Guide

Decision rules for where documentation lives.

---

## .agent/rules/ vs docs/

.agent/rules/ is for navigation and behavioral instructions: things that tell a reader
(agent or human) how to operate in this repo or move across repos. Content here is
optimized for quick lookup, not reading.

    .agent/rules/ contains:
      ecosystem-map.md       -- lookup table: where are the repos and what are they
      agent-guide.md         -- how agents should navigate the ecosystem
      doc-placement-guide.md -- this file: where does a given doc belong

docs/ is for content about the system: things that explain what the system is and why
it works the way it does. Content here is meant to be read by humans and agents alike.

    docs/architecture/ contains:
      arch-principles.md     -- design philosophy and rationale
      system-overview.md     -- current state of the pipeline and components
      cross-app-auth.md      -- auth across repos
      graduation-framework.md -- stage definitions for POC -> stable

Rule of thumb: if it is a lookup or a behavioral rule, it goes in .agent/rules/.
If it explains the system, it goes in docs/.

---

## docs/ subdirectory guide

    docs/architecture/   -- post-implementation rationale; explains what was built and why
    docs/plan/           -- pre-implementation design docs; tradeoffs and alternatives
                            considered before building (a plan discusses options,
                            architecture documents what manifested)
    docs/ops/            -- runbooks, deployment steps, operating procedures
    docs/misc/           -- tasks, feature notes, things that don't fit above

---

## Where does a given doc belong?

Does this doc describe something that spans 2+ repos or components?
  YES -> heartwood/docs/architecture/
  NO  -> the component's own docs/

Is this a schema or contract for a specific data format?
  YES -> <component>/pipeline/input/standards/ or pipeline/output/standards/
         or api/input/standards/ or api/output/standards/
  NO  -> continue

Is this a runbook for operating or deploying a specific component?
  YES -> <component>/docs/ops/
  NO  -> if it spans components: heartwood/docs/ops/

Is this orientation or design rationale for the whole ecosystem?
  YES -> heartwood/docs/architecture/

Is this a design doc written before implementation?
  YES -> <component>/docs/plan/ or heartwood/docs/plan/ if cross-repo

Is this a navigation aid or behavioral rule for agents?
  YES -> heartwood/.agent/rules/ or <component>/.agent/rules/
