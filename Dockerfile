# syntax=docker/dockerfile:1

FROM python:3.8-slim-buster
STOPSIGNAL SIGINT

ARG USER=apps

ENV PUID 568
ENV PGID 568

RUN groupadd -g $PGID -o $USER && \
useradd -m -N -u $PUID -g $PGID $USER && \
usermod -aG sudo $USER && \
echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers && \
chmod 0440 /etc/sudoers && chmod g+w /etc/passwd && \
mkdir /app && mkdir /app/temp_downloads && mkdir /app/db && \
chmod 777 /app && chmod 666 /app/temp_downloads && chmod 777 /app/db

USER $USER

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY . .

CMD [ "python3", "/app/Kapowarr.py" ]
