# pull official base image
FROM python:3.7-alpine
LABEL Jose Pinto

# install dependencies
# RUN apk update && \
#   apk add --virtual build-deps gcc python-dev musl-dev && \
#   apk add postgresql-dev libffi-dev make && \
#   apk add netcat-openbsd

RUN apk add --update --no-cache postgresql-client jpeg-dev

RUN apk add --update --no-cache --virtual .tmp-build-deps \
  gcc python-dev musl-dev zlib zlib-dev linux-headers postgresql-dev libffi-dev make

# set environment varibles
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# add and install requirements
RUN pip install pipenv
COPY Pipfile* /tmp/
RUN cd /tmp && pipenv lock --requirements > requirements.txt
RUN pip install --upgrade pip
RUN pip install -r /tmp/requirements.txt

RUN apk del .tmp-build-deps

# set working directory
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# create a user to run the application using docker and switch to it
RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static
RUN adduser -D user
RUN chown -R user:user /vol/
RUN chmod -R 755 /vol/web
USER user