# Stage 1: download runner & tools
FROM mcr.microsoft.com/dotnet/runtime-deps:8.0-jammy AS build
ARG RUNNER_VERSION=2.308.0
ARG DOCKER_VERSION=28.0.1
ARG BUILDX_VERSION=0.21.2

# Install prerequisites
RUN apt-get update && apt-get install -y curl unzip && rm -rf /var/lib/apt/lists/*

WORKDIR /actions-runner
# Download and extract runner
RUN curl -fSL -o runner.tar.gz \
      https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
  && tar xzf runner.tar.gz && rm runner.tar.gz

# Download Docker CLI & Buildx plugin
RUN curl -fSL -o docker.tgz \
      https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz \
  && tar zxvf docker.tgz --strip-components=1 docker/docker \
  && mv docker* /usr/bin/ \
  && rm -rf docker.tgz

RUN curl -fSL -o /usr/libexec/docker/cli-plugins/docker-buildx \
      https://github.com/docker/buildx/releases/download/v${BUILDX_VERSION}/buildx-v${BUILDX_VERSION}.linux-amd64 \
  && chmod +x /usr/libexec/docker/cli-plugins/docker-buildx

# Stage 2: final image
FROM mcr.microsoft.com/dotnet/runtime-deps:8.0-jammy
ENV RUNNER_WORKDIR=/tmp/_work
ENV ACTIONS_RUNNER_PRINT_LOG_TO_STDOUT=1

# Copy runner and docker from build stage
COPY --from=build /actions-runner /actions-runner
COPY --from=build /usr/bin/docker /usr/bin/docker
COPY --from=build /usr/libexec/docker /usr/libexec/docker

# Create a non-root user
RUN groupadd -g 1001 runner && useradd -m -u 1001 -g runner runner \
  && mkdir -p $RUNNER_WORKDIR && chown runner:runner $RUNNER_WORKDIR

USER runner
WORKDIR /home/runner

# Entrypoint will configure & launch
ENTRYPOINT ["/actions-runner/bin/runsvc.sh"]