FROM node:18-alpine

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json ./

RUN npm install

# Copy app source code
COPY . .

# Create logs directory
RUN mkdir -p logs

#Expose port and start application
EXPOSE 8080

CMD [ "npm", "start" ]