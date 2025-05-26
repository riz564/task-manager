FROM python:3.9

WORKDIR /app

COPY requirements.txt .
ENV PIP_NO_VERIFY_CERTS=1
ENV PIP_CERT=/dev/null

RUN pip install --upgrade pip
RUN pip install --no-cache-dir \
  --trusted-host pypi.ci.artifacts.walmart.com \
  --index-url https://pypi.ci.artifacts.walmart.com/artifactory/api/pypi/infosec-eis-pypi/simple \
  -r requirements.txt

COPY ./app ./app
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]
