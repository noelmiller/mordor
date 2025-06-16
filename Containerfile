ARG BASE_IMAGE_NAME="${BASE_IMAGE_NAME:-base-main}"
ARG IMAGE_TAG="${IMAGE_TAG:-latest}"

FROM ghcr.io/ublue-os/${BASE_IMAGE_NAME}:${IMAGE_TAG} AS mordor

COPY system_files /
COPY scripts /scripts

RUN /scripts/preconfigure.sh && \
    /scripts/install_1password.sh && \
    /scripts/install_packages.sh && \
    /scripts/enable_services.sh && \
    /scripts/just.sh && \
    /scripts/cleanup.sh && \
    ostree container commit
