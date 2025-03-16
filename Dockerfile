FROM python:3.13-slim

RUN mkdir -p /home/user

RUN addgroup --system user && adduser --system --group user

ENV HOME=/home/user
ENV APP_HOME=/home/user/web
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY requirements.txt $APP_HOME

RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

COPY . $APP_HOME

RUN chown -R user:user $APP_HOME

USER user

EXPOSE 8000

ENTRYPOINT ["/home/user/web/entrypoint.sh"]
