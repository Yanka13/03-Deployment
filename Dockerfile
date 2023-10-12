FROM python:3.8.14-slim

#Do not use env as this would persist after the build and would impact your containers, children images
ARG DEBIAN_FRONTEND=noninteractive

# force the stdout and stderr streams to be unbuffered.
ENV PYTHONUNBUFFERED 1

RUN apt-get -y update \
    && apt-get -y upgrade \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \



ENV PATH="${PATH}:/home/runner/.local/bin"

WORKDIR /home/runner/app

COPY ./  ./

RUN pip install --upgrade pip \
    && pip install  poetry \
    && poetry install --only main

EXPOSE 8000

ENTRYPOINT [ "poetry", "run" ]

# $CHALLENGIFY_BEGIN
CMD uvicorn app.main:app --host 0.0.0.0 --port $PORT
# $CHALLENGIFY_END
#CMD uvicorn app.main:app --host 0.0.0.0 --port 8000
