# Doc Placement Guide

> Status: STUB -- to be filled in Part 4

Decision rules for where documentation lives.

## Decision tree

Does this doc describe something that spans 2+ repos or components?
  YES -> heartwood/docs/architecture/
  NO  -> the component's own docs/

Is this a schema or contract for a specific data format?
  YES -> <component>/pipeline/input/standards/ or pipeline/output/standards/
         or api/input/standards/ or api/output/standards/
  NO  -> continue

Is this a runbook for operating or deploying a specific component?
  YES -> <component>/docs/misc/
  NO  -> if it spans components: heartwood/docs/misc/

Is this orientation or design rationale for the whole ecosystem?
  YES -> heartwood/docs/architecture/ or heartwood/docs/design/

Is this a design doc written before implementation?
  YES -> <component>/docs/design/ or heartwood/docs/design/ if cross-repo
