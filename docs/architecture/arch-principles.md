# Architecture Principles

This file documents the "why" behind architectural decisions across the Good Shepherd ecosystem.
It is explanation-layer material: durable rationale, not how-to steps.

---

## What Good Shepherd is

Good Shepherd is a conservation decision support system (DSS). It helps ecologists collect
field data, surface trends and run rigorous experiments, and eventually deliver ecological
knowledge to practitioners and communities who own or manage land.

It operates in three layers that run continuously and in parallel -- the forest does not
remain static, and neither does the system:

    Layer 1: Data infrastructure
      Collect, clean, and standardize conservation field data.
      Components: fomomon, form-idable, good-shepherd server (auth + S3 backbone)

    Layer 2: Decision support
      Surface trends, enable comparisons, support rigorous ecology experiments (A/B testing
      of planting strategies, tracking ANR, measuring invasive removal over time, etc).
      Components: fomo (web UX), indicators, alienwise, PlantWise, dlt

    Layer 3: Knowledge delivery
      Distill models and insights for practitioners and communities who lack scientific
      training but own or manage the land.
      Components: bickr and future models -- each gated by an ethics review

These layers are not a progression toward a final state. All three must run together for
the system to be useful.

---

## POC-first philosophy

Build fast, validate in the field, then stabilize. Most components start as prototypes in
good-shepherd/examples/ before graduating to their own repos. The graduation framework
(see docs/architecture/graduation-framework.md) defines when and how to make that move.

good-shepherd/examples/ is a permanent incubator. It also serves as a demo harness for
showing future-looking integrations to partners before those integrations are stable enough
to be part of the main stack.

---

## Dual mode: standalone and DSS node

Every component must work in two modes:

    Standalone: the component can be deployed and used independently, without any other
    part of the Good Shepherd stack. fomomon can capture site photos alone. form-idable
    can extract forms to Excel alone. PlantWise can run SDMs alone.

    DSS node: the component can also be integrated into the unified DSS pipeline, where
    its outputs are consumed by other components.

Both modes must be maintained. A component that only works as part of the DSS is too
tightly coupled. A component that cannot be integrated is not useful to the platform.

---

## good-shepherd as glue

good-shepherd is two things:

1. A backbone server providing auth and S3 connectivity across components
2. An incubator (examples/) for prototypes not yet ready for their own repos

As components mature, they graduate out of examples/ into standalone repos. What remains
in good-shepherd is the connective tissue: data standardization pipelines, indicator
prototypes, and the harnesses that stitch standalone components into a unified system.

The DSS UX has two faces:

- Web: fomo (Vue3 web app)
- Field: fomomon (Flutter phone app)

good-shepherd provides the plumbing underneath both.

---

## Model integration gate

A model (bickr, dlt, or any future model) moves from standalone research into the DSS
only after:

1. An ethics review covering data use, bias, and recommendations
2. Policy enforcement is defined (training frequency, data handling, auditability)

This gate exists because models that give recommendations to land owners and communities
carry real consequences. Speed of integration is less important than trust.

---

## Standards as the integration contract

There is no central database mediating components by default (see S3-first below).
Standards fill that role instead. Each component defines the schema of what it accepts
and what it produces in its pipeline/input/standards/ and pipeline/output/standards/
directories. These schemas are the contract that makes DSS integration possible without
tight coupling. A component that does not define its standards cannot be integrated.

---

## S3-first and the concurrency tradeoff

The default data residency model is S3. Components write directly to S3 where possible,
avoiding the operational overhead of a database (hosting, locking, migrations, bottlenecks
on experimentation velocity).

This works because ecology is slow. Most field operations involve one user on one device
at a time, so concurrency races are vanishingly rare.

However, this is a design assumption to keep evaluating, not a permanent rule.

Two constraints must always be met regardless of storage choice:

1. Every component that writes data must maintain an index file (e.g. sites.json,
   db.json) structured so that data can be consumed by other components or migrated
   without rewriting the producer.
2. If realistic concurrency requirements emerge, the team must huddle and choose
   explicitly from: S3 file locks / API mediation / database. The decision criterion
   is "cost as complexity": add a database if it reduces overall system complexity
   and long-run operational cost, not just because concurrency exists. Adding a
   database prematurely introduces hosting costs, lock contention, and migration
   surface that slows experimentation.

---

## How components communicate

API-first between components. The good-shepherd server is the canonical transversal
service: any component can call it for auth, session data, or S3 operations regardless
of where that component sits in the pipeline.

Pipeline data (field -> indicator -> model output) flows via S3 and index files, not
direct API calls between components. This keeps components decoupled and independently
deployable.

---

## Auth model

Cognito JWT, enforced at API Gateway. Application code does not implement auth logic.
See docs/architecture/cross-app-auth.md for the full picture.

---

## Technology preferences

- Backend: Python, FastAPI
- Frontend: Vue3 or simple HTML/JS for POCs; Flutter for mobile
- Heavy operations (nursery DB, structured records): Frappe
- Geospatial coordinate system default: EPSG:4326 unless file metadata states otherwise
- Minimize new dependencies; justify additions in the PR

---

## Security and privacy

Security and privacy are not features to add later. Field data contains location information
about real conservation sites and potentially about communities. Any component handling
location, image, or user data must consider:

- Who can read this data
- What happens if it leaks
- Whether the data subject (whoever can read it) has meaningful consent
- How we manage withdrawal of consent
- How the data subject can share the data

For models in Layer 3 specifically: the ethics review gate (see model integration gate
above) is the primary enforcement mechanism. For infrastructure: Cognito + API Gateway
is the enforcement boundary.

---

## When to add a new repo vs extend an existing one

Add a new repo when:

- The component has a clear standalone use case (dual mode requirement above)
- It has its own deployment lifecycle independent of good-shepherd
- It has its own user-facing interface or pipeline position

Extend an existing repo (or use good-shepherd/examples/) when:

- The component is a prototype not yet validated in the field
- It has no standalone use case and exists only as glue
- It is a minor variant of an existing component
