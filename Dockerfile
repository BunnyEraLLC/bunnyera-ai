# Stage 1: Builder
# We use a multi-stage build to compile dependencies and keep the final image small
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Install system dependencies required for building some node modules (like python, make, g++)
# Only if needed. For now, we assume standard dependencies.
RUN apk add --no-cache python3 make g++

# Copy package files for dependency installation
COPY package*.json ./

# Install dependencies (including devDependencies for build/test if needed, or just production)
# npm ci is faster and more reliable for CI/CD
RUN npm ci

# Copy source code
COPY . .

# If you have a build step (e.g., for TypeScript or frontend), run it here
# RUN npm run build

# Stage 2: Production Runner
FROM node:18-alpine AS runner

# Set working directory
WORKDIR /app

# Set environment to production
ENV NODE_ENV=production

# Install curl for healthcheck (Alpine doesn't have it by default)
RUN apk add --no-cache curl

# Create a non-root user and group for security
RUN addgroup -S bunnyera && adduser -S bunnyera -G bunnyera

# Copy only necessary files from builder
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app .

# Change ownership of the application files to the non-root user
RUN chown -R bunnyera:bunnyera /app

# Switch to non-root user
USER bunnyera

# Expose the application port
EXPOSE 3000

# Health Check
# Checks if the server is responding on /health endpoint
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

# Start the application
CMD ["node", "server.js"]
