FROM python:3.9-alpine as base
WORKDIR /wheels
RUN apk add --update --no-cache \
    alpine-sdk \
    postgresql-dev
COPY requirements.txt .
RUN pip wheel -r requirements.txt

FROM python:3.9-alpine

ENV POSTGRES_USER=$TF_VAR_rds_user
ENV POSTGRES_PASSWORD=$TF_VAR_rds_passwd
ENV POSTGRES_DB=$TF_VAR_rds_db
ENV POSTGRES_HOST=$DB_IP
ENV POSTGRES_PORT=5432

# Construct the DATABASE_URL using environment variables
ENV DATABASE_URL="postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}"
ENV DJANGO_ALLOWED_HOSTS=*

RUN apk add libpq
COPY --from=base /wheels /wheels
COPY . .
RUN pip install \
        -r /wheels/requirements.txt \
        -f /wheels \
    && rm -rf /wheels
EXPOSE 8000
RUN python manage.py migrate 
CMD gunicorn --bind 0.0.0.0:8000 --worker-tmp-dir /dev/shm mysite.wsgi