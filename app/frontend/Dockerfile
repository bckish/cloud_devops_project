# =========================
# Stage 0 - Build (Node)
# =========================
FROM node:22 AS build-stage

WORKDIR /app/frontend

# Copy package files
COPY frontend/package.json frontend/package-lock.json ./

# Install dependencies
RUN rm -rf node_modules package-lock.json
RUN npm install

# Copy source
COPY frontend/ .

# Build-time API URL
ARG VITE_API_URL
ENV VITE_API_URL=$VITE_API_URL

# Build app
RUN npm run build

# =========================
# Stage 1 - Serve (Nginx)
# =========================
FROM nginx:1

# Copy build output
COPY --from=build-stage /app/frontend/dist/ /usr/share/nginx/html

# Create extra config dir
RUN mkdir -p /etc/nginx/extra-conf.d

# Copy nginx configs
COPY frontend/nginx.conf /etc/nginx/conf.d/default.conf
COPY frontend/nginx-backend-not-found.conf /etc/nginx/extra-conf.d/backend-not-found.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]