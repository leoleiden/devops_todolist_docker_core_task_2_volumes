# Stage 1: Build Stage
ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION} as builder

# Set the working directory
WORKDIR /app
COPY . .

# Stage 2: Run Stage
FROM python:${PYTHON_VERSION} as run

WORKDIR /app

ENV PYTHONUNBUFFERED=1

COPY --from=builder /app .

COPY entrypoint.sh /app/

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Run database migrations and start the Django application
ENTRYPOINT ["/app/entrypoint.sh"]