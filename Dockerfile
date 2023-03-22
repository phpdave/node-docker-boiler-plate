# Use the official Node.js 12 image as the base image
FROM node:12

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install the dependencies
RUN npm ci

# Copy the rest of the application code to the working directory
COPY . .

# Expose the port your app will run on (e.g., 3000)
EXPOSE 3000

# Start the application
CMD ["npm", "start"]