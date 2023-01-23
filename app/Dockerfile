FROM python:3.9-alpine as base
WORKDIR /wheels
RUN apk add --update --no-cache \
    alpine-sdk \
    postgresql-dev
COPY requirements.txt .
RUN pip wheel -r requirements.txt

FROM python:3.9-alpine
ENV DJANGO_ALLOWED_HOSTS=*
ENV DATABASE_URL="postgres://postgres:password123@<DB_IP>:5432/djangodb"
RUN apk add libpq
COPY --from=base /wheels /wheels
COPY . .
RUN pip install \
        -r /wheels/requirements.txt \
        -f /wheels \
    && rm -rf /wheels
EXPOSE 8000
RUN ls
RUN python manage.py migrate 
CMD gunicorn --bind 0.0.0.0:8000 --worker-tmp-dir /dev/shm mysite.wsgi