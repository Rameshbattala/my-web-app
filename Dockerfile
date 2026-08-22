# Base Image
FROM nginx:1.27-alpine

# Metadata
LABEL maintainer="rameshbattala"
LABEL application="my-web-app"
LABEL version="1.0.0"

# Copy application files
COPY index.html /usr/share/nginx/html/index.html

# Create a simple health check endpoint
RUN echo "OK" > /usr/share/nginx/html/health.html

# Expose application port
EXPOSE 80

# Health Check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost/health.html || exit 1

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]