FROM alpine:latest

COPY .   /var/app

RUN chmod +x /var/app/run.sh

WORKDIR /var/app/

RUN apk update && \
 apk add python postgresql-libs py-pip && \
 apk add --virtual .build-deps gcc python-dev musl-dev postgresql-dev curl && \
 python -m pip install -r requirements.txt --no-cache-dir && \
 apk --purge del .build-deps

EXPOSE 8000

WORKDIR /var/app/

CMD /var/app/run.sh
