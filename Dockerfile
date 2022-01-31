FROM node:16
RUN apt-get update && apt-get -y install cron

WORKDIR /usr/src/app

COPY . .

# Build the TS app
RUN npm ci
RUN npm run build

# Install the cron job
COPY ./cron /etc/cron.d/fastmail-delayed-rules
RUN rm ./cron
RUN chmod 0644 /etc/cron.d/fastmail-delayed-rules
RUN crontab /etc/cron.d/fastmail-delayed-rules

# Initialize log file
RUN touch /var/log/mail.log

# Make cron script runnable
RUN chmod +x ./run.sh

# Start cron, and keep the process open so Docker doesn't kill the container
CMD ["cron", "-f"]
