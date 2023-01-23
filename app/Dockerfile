FROM python:3.9-alpine as base
RUN apk add --update --virtual .build-deps \
    build-base \
    postgresql-dev \
    python3-dev \
    libpq

COPY requirements.txt /app/requirements.txt
RUN pip install -r /app/requirements.txt

FROM python:3.9-alpine
ENV DJANGO_ALLOWED_HOSTS=*
ENV DATABASE_URL="postgres://postgres:password123@<DB_IP>:5432/djangodb"
RUN apk add libpq
COPY --from=base /usr/local/lib/python3.9/site-packages/ /usr/local/lib/python3.9/site-packages/
COPY --from=base /usr/local/bin/ /usr/local/bin/
COPY . /app
RUN rm -r /usr/local/lib/python3.9/site-packages/pip/ /usr/local/lib/python3.9/site-packages/setuptools/
EXPOSE 8000
RUN python /app/manage.py migrate 
CMD gunicorn --bind 0.0.0.0:8000 --worker-tmp-dir /dev/shm mysite.wsgi