# Agent Guide

> Status: STUB -- to be filled in Part 4

Instructions for agents navigating the Good Shepherd ecosystem.

## Navigation rules

- Start in heartwood when the task spans repos
- Start in the component repo when the task is component-specific
- Use ecosystem-map.md as the index, not file search
- Do not load all repos into context; navigate to the relevant one
- AGENTS.md is the agent entry point; README.md is the human entry point
  Either falls back to the other if one is absent

## Expected structure in every repo

    <repo>/
      README.md              - human entry point
      AGENTS.md              - agent entry point, kept minimal
      STATUS.md              - graduation stage
      .agent/rules/          - detailed agent context

      pipeline/
        README.md            - where this sits in field -> indicator -> model
        input/
          standards/         - schemas for what this stage accepts
          examples/          - sample input files for testing
        output/
          standards/         - schemas for what this stage produces
          examples/          - sample output files

      api/                   - only present if this component exposes an API
        README.md
        input/
          standards/
          examples/
        output/
          standards/
          examples/

      docs/
        architecture/        - post-implementation rationale
        design/              - pre-implementation design docs
        misc/                - tasks, features, runbooks, other

      <source dirs>

## Standards are co-located with the things that use them

Schemas live inside pipeline/ or api/ next to the examples that exercise them.
This is intentional: it makes it harder to change the contract without noticing
the standard needs to change too.
