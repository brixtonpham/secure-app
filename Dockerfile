# Stage 1: Build
FROM node:18-alpine AS build

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install --production

# Copy source code
COPY . .

# Stage 2: Runtime
FROM node:18-alpine

WORKDIR /app

# Copy only necessary files from the build stage
COPY --from=build /app /app

# Expose port
EXPOSE 3000

# Start the application
CMD [ "npm", "start" ]
