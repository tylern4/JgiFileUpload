FROM python:3-alpine

LABEL maintainer="Nick Tyler tylern at lbl dot gov"

# Make uploads folder for files
RUN mkdir /uploads
# Look for python modules in /app where we'll put out web app
ENV PYTHONPATH=/app

# Copy in required modules
COPY requirements.txt requirements.txt
RUN apk add --no-cache --virtual .build-deps gcc libc-dev \
    && pip install -r requirements.txt \
    && apk del .build-deps gcc libc-dev

# Copy in entrypoint and start
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
COPY ./start.sh /start.sh
RUN chmod +x /start.sh

# Configuration for starting server
COPY ./gunicorn_conf.py /gunicorn_conf.py

# Copy in the application
COPY ./app /app
WORKDIR /app/

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]

# Run the start script, it will check for an /app/prestart.sh script (e.g. for migrations)
# And then will start Gunicorn with Meinheld
CMD ["/start.sh"]
