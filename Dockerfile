# Step 1: Use Node.js to build the Angular application
FROM node:16 as build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json for dependency installation
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the Angular project files into the container
COPY . .

# Build the Angular app for production
RUN npm run build --prod

# Step 2: Use Nginx to serve the application
FROM nginx:alpine

# Copy the built Angular app from the previous step
COPY --from=build /app/dist/photographer /usr/share/nginx/html


# Expose port 80 for the Nginx server
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
