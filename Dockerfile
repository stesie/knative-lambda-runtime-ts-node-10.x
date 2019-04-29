FROM node:10-alpine
WORKDIR /opt

RUN apk --no-cache add curl \
    && API_VERSION=$(curl -sI https://github.com/triggermesh/aws-custom-runtime/releases/latest | grep "Location:" | awk -F "/" '{print $NF}' | tr -d "\r") \
    && curl -sL https://github.com/triggermesh/aws-custom-runtime/releases/download/${API_VERSION}/aws-custom-runtime > aws-custom-runtime \
    && chmod +x aws-custom-runtime \
    && npm -g install ts-node typescript

ENV LAMBDA_TASK_ROOT "/opt"

ADD bootstrap /opt
