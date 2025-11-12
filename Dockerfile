# Stage 1: Build the project using zola
FROM ghcr.io/getzola/zola:v0.17.2 AS builder

WORKDIR /app
COPY . .
RUN ["zola", "build"]

# Stage 2: Serve the static site with unprivileged Nginx
FROM nginxinc/nginx-unprivileged:mainline-alpine

# Copy the built static files from the builder stage
COPY --from=builder /app/public /usr/share/nginx/html

# Expose the default port (8080) for the unprivileged Nginx image
EXPOSE 3000
