FROM python:3.8

ENV DJANGO_ALLOWED_HOSTS=*
ENV DATABASE_URL="postgres://postgres:<PASS>@<PRIVATE_IP>:5432/djangodb"

WORKDIR /app
COPY . .
RUN pip install -r requirements.txt  --no-cache-dir 
EXPOSE 8000

RUN python manage.py migrate 
CMD gunicorn --worker-tmp-dir /dev/shm mysite.wsgi