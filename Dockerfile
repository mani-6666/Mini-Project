# Base image 
FROM node:18-alpine AS build 
# Set working directory 
WORKDIR /app 
# Copy and install client dependencies 
COPY client/package*.json ./client/ 
RUN cd client && npm install 
# Copy and build frontend 
COPY client ./client 
RUN cd client && npm run build 
# Copy and setup backend 
COPY server ./server 
RUN cd server && npm install 
# Expose port and start backend 
EXPOSE 5000 
CMD ["node", "server/index.js"] 
