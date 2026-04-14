#!/usr/bin/env bash
# ── config.sh ──────────────────────────────────────────────────────────────────
# THE ONLY FILE YOU NEED TO EDIT.
# Copy this entire deploy/ directory into your POC server directory, fill in the
# values below, then run:
#   ./deploy/setup.sh    ← once, creates AWS infra
#   ./deploy/deploy.sh   ← on every code change
# ───────────────────────────────────────────────────────────────────────────────

# REQUIRED: unique name for this POC.
# Used as prefix for all AWS resources (ECR repo, Lambda, IAM role).
# Lowercase, hyphens only, max 20 chars.
APP_NAME="my-poc"

# REQUIRED: your AWS region.
AWS_REGION="ap-south-1"

# REQUIRED: email address for the Lambda cost alert.
ALERT_EMAIL="you@example.com"

# REQUIRED: path your server exposes for health checks (must return HTTP 200).
# Lambda Web Adapter polls this before marking the function ready.
HEALTH_CHECK_PATH="/health"

# Monthly Lambda spend threshold in USD.
# A budget alert email fires at 80% of this value.
# Covers ALL Lambda functions in the account — set high enough not to
# false-fire from other functions (e.g. good-shepherd).
BUDGET_LIMIT_USD=10

# Max simultaneous Lambda executions for this function.
# Hard ceiling on concurrent cost — abuse gets 429s above this limit.
# Per-function, so it doesn't affect other Lambdas.
RESERVED_CONCURRENCY=10

# Port uvicorn listens on inside the container. Keep 8070 unless you have a conflict.
SERVER_PORT=8070

# Comma-separated response headers the browser is allowed to read.
# Add any custom headers your endpoints return (e.g. X-Row-Count).
CORS_EXPOSE_HEADERS="Content-Disposition"

# Lambda memory (MB) and max execution time (seconds).
LAMBDA_MEMORY_MB=512
LAMBDA_TIMEOUT_S=60

# ── Derived — do not edit below this line ─────────────────────────────────────
export APP_NAME AWS_REGION SERVER_PORT CORS_EXPOSE_HEADERS
export LAMBDA_MEMORY_MB LAMBDA_TIMEOUT_S RESERVED_CONCURRENCY
export BUDGET_LIMIT_USD ALERT_EMAIL HEALTH_CHECK_PATH

export AWS_ACCOUNT_ID
AWS_ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text 2>/dev/null)"

export ECR_REPO="${APP_NAME}"
export ECR_URI="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}"
export LAMBDA_FUNCTION="${APP_NAME}"
export LAMBDA_ROLE_NAME="${APP_NAME}-role"
export IMAGE="${APP_NAME}:latest"
