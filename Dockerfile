FROM python:3.11-slim AS base
ENV PATH /opt/venv/bin:$PATH
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

FROM base AS builder
WORKDIR /opt
RUN python -m venv venv
RUN pip install poetry
COPY pyproject.toml poetry.lock ./
RUN poetry config virtualenvs.create false
RUN poetry install --no-interaction --no-root --only main

FROM base
ARG PORT=8000
ENV PORT $PORT
EXPOSE $PORT
WORKDIR /opt
COPY --from=builder /opt/venv venv
COPY app app
RUN useradd -r user
USER user
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 app.main:app