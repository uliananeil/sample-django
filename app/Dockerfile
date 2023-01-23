FROM python:3.9-alpine as base
RUN apk update && apk add build-base


WORKDIR /source
COPY requirements.txt /source/
RUN . python3 -m ensurepip --upgrade && \
python3 -m pip install -r /source/requirements.txt


FROM python:3.9-alpine
ENV DJANGO_ALLOWED_HOSTS=*
ENV DATABASE_URL="postgres://postgres:password123@<DB_IP>:5432/djangodb"
RUN apk upgrade --no-cache
WORKDIR /source
COPY --from=base /source /source
EXPOSE 8000
RUN python manage.py migrate 
CMD gunicorn --bind 0.0.0.0:8000 --worker-tmp-dir /dev/shm mysite.wsgi