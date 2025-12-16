# =========================
# Stage 1: Build Frontend
# =========================
FROM node:18-alpine AS frontend-build

WORKDIR /app

# Install frontend dependencies
COPY client/package*.json ./client/
RUN cd client && npm install

# Build frontend
COPY client ./client
RUN cd client && npm run build


# =========================
# Stage 2: Build Backend
# =========================
FROM node:18-alpine AS backend-build

WORKDIR /app

# Install backend dependencies
COPY server/package*.json ./server/
RUN cd server && npm install

# Copy backend source
COPY server ./server


# =========================
# Stage 3: Production Image
# =========================
FROM node:18-alpine

WORKDIR /app

# Copy backend from backend-build stage
COPY --from=backend-build /app/server ./server

# Copy built frontend from frontend-build stage
COPY --from=frontend-build /app/client/build ./server/client/build

# Expose backend port
EXPOSE 5000

# Start backend server
CMD ["node", "server/index.js"]
