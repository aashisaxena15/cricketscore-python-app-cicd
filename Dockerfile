FROM python:latest
WORKDIR /app
COPY . ./
RUN pip install -r requirements.txt
EXPOSE 8080
CMD ["python", "app.py"]
# This Dockerfile is for a simple Python application that uses Flask to serve a web application.
# It uses the latest version of Python as the base image and sets the working directory to /app.
# It copies the current directory contents into the container at /app and installs the required Python packages listed in requirements.txt.
# Finally, it exposes port 8080 and runs the app.py script when the container starts.
# This Dockerfile is for a simple Python application that uses Flask to serve a web application.
# It uses the latest version of Python as the base image and sets the working directory to /app.
