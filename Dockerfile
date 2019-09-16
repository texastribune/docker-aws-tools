FROM python:3
MAINTAINER tech@texastribune.org

ENV DEBIAN_FRONTEND=noninteractive
RUN ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime
RUN apt-get update && \
  apt-get install -yq python3 python-pip wget awscli git curl && \
  dpkg-reconfigure --frontend noninteractive tzdata
#ADD requirements.txt /app
RUN pip install --upgrade pip
ENV POETRY_VERSION=0.12.17
ENV PATH=/root/.poetry/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python \
  && poetry config settings.virtualenvs.create false
ENV GHBACKUP_VERSION=1.12.0
RUN wget https://github.com/qvl/ghbackup/releases/download/v${GHBACKUP_VERSION}/ghbackup_${GHBACKUP_VERSION}_linux_amd64.deb && \
  dpkg -i ghbackup_${GHBACKUP_VERSION}_linux_amd64.deb && \
  rm ghbackup_${GHBACKUP_VERSION}_linux_amd64.deb

COPY pyproject.toml poetry.lock /app/
WORKDIR /app
RUN poetry install
ADD src /app/
