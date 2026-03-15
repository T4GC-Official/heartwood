# Heartwood

You are in the Heartwood repo, the meta-architecture hub for the Good Shepherd ecosystem.

## What this is

Heartwood documents cross-repo architecture, component relationships, and the
philosophy for how components evolve and interact. It does NOT contain component
code or component-specific standards.

## Quick start for agents

1. Read .agent/rules/ecosystem-map.md -- all components, paths, purposes
2. Read docs/architecture/arch-principles.md -- design philosophy
3. For cross-repo navigation tasks, read .agent/rules/agent-guide.md
4. All repos are cloned to ./repos/ via setup.sh (run it if repos/ is empty)

## Entry point rule (applies to all repos)

- Agents: read AGENTS.md first, fall back to README.md if absent
- Humans: read README.md first, fall back to AGENTS.md if absent

## What NOT to look for here

Component-specific schemas, standards, pipeline contracts, and API docs live in
each component's own repo. The ecosystem-map will point you to the right place.
