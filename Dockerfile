FROM python:3.12-slim as builder

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc

COPY ./requirements/common.txt .
COPY ./requirements/dev.txt .
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /app/wheels -r dev.txt

FROM python:3.12-slim

WORKDIR /app

COPY --from=builder /app/wheels /wheels
COPY --from=builder /app/common.txt .
COPY --from=builder /app/dev.txt .

RUN pip install --no-cache /wheels/*

COPY . .
