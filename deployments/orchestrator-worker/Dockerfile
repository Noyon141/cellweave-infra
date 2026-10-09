# Multi-stage production container for CellWeave TypeScript Temporal Worker
# Designed for lightweight always-on container hosting (Fly.io, Render, Railway, or AWS ECS/Fargate)

FROM node:20-alpine AS builder

WORKDIR /app

# Enable corepack and install dependencies
RUN corepack enable && corepack prepare pnpm@latest --activate

COPY package.json pnpm-lock.yaml* ./
RUN pnpm install --frozen-lockfile

COPY tsconfig.json ./
COPY src ./src

RUN pnpm build

# Runtime Stage
FROM node:20-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production

RUN corepack enable && corepack prepare pnpm@latest --activate

# Create non-root user for security
RUN addgroup --system --gid 1001 nodejs && \
    adduser --system --uid 1001 temporalworker

COPY package.json pnpm-lock.yaml* ./
RUN pnpm install --prod --frozen-lockfile

COPY --from=builder /app/dist ./dist

USER temporalworker

# Graceful shutdown handling on SIGTERM
STOPSIGNAL SIGTERM

CMD ["node", "dist/worker.js"]
