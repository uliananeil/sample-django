FROM python:3.9-alpine as base
RUN apk update && apk add build-base

COPY . /code/
WORKDIR /code
RUN pip install -r requirements.txt

FROM python:3.9-alpine
ENV DJANGO_ALLOWED_HOSTS=*
ENV DATABASE_URL="postgres://postgres:password123@<DB_IP>:5432/djangobd"
COPY --from=base /code/ /code
WORKDIR /code
EXPOSE 8000
RUN python manage.py migrate 
CMD gunicorn --bind 0.0.0.0:8000 --worker-tmp-dir /dev/shm mysite.wsgi