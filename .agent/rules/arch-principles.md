# Architecture Principles

> Status: STUB -- to be filled in Part 3

This file documents the "why" behind architectural decisions across the Good Shepherd ecosystem.
It is explanation-layer material: durable rationale, not how-to steps.

Topics to cover:
- What Good Shepherd is trying to be
- POC-first philosophy: build fast, validate in field, then stabilize
- The field -> indicator -> model output pipeline and where each component sits
- The distinction between pipeline contracts and transversal API services
- How components communicate: API-first, schemas as contracts
- Technology preferences: Python backend, Vue3/HTML frontend, FastAPI, Frappe
- Coordinate system default: EPSG:4326
- Auth model: Cognito JWT enforced at API Gateway
- Data residency and S3 conventions
- When to add a new repo vs extend an existing one
