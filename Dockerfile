# Use the official Python image
FROM python:3.9-slim

# Install necessary packages
RUN pip install kubernetes

# Set the working directory
WORKDIR /app

# Copy the Python script into the container
COPY pod-event-logger.py .

# Run the Python script
CMD ["python", "pod-event-logger.py"]
