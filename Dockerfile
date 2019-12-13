# pull official base image
FROM python:3.7-alpine
LABEL Jose Pinto

# install dependencies
RUN apk update && \
  apk add --virtual build-deps gcc python-dev musl-dev && \
  apk add postgresql-dev libffi-dev && \
  apk add netcat-openbsd

# set environment varibles
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# add and install requirements
RUN pip install pipenv
COPY Pipfile* /tmp/
RUN cd /tmp && pipenv lock --requirements > requirements.txt
RUN pip install --upgrade pip
RUN pip install -r /tmp/requirements.txt

# set working directory
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# create a user to run the application using docker and switch to it
RUN adduser -D user
USER user