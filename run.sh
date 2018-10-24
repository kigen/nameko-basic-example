#!/bin/sh

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "         Example Service              "
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

echo "Checking if rabbitmq server is up!"

while ! nc -z "${RABBIT_HOST:localhost}" 5672; do sleep 3; done
echo "RabbitMQ server: ✓"

echo "Starting application service server"
# Run Service
nameko run --config config.yml app.service --backdoor 3000