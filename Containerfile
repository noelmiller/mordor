ARG BASE_IMAGE_NAME="${BASE_IMAGE_NAME:-base-main}"
ARG IMAGE_TAG="${IMAGE_TAG:-43}"
FROM ghcr.io/ublue-os/akmods:main-43 as akmods

FROM ghcr.io/ublue-os/${BASE_IMAGE_NAME}:${IMAGE_TAG} AS mordor

COPY system_files /
COPY scripts /scripts

RUN --mount=type=bind,from=akmods,source=/rpms,dst=/tmp/akmods-rpms \
  /scripts/01_preconfigure.sh && \
  /scripts/02_install_1password.sh && \
  /scripts/03_install_packages.sh && \
  /scripts/04_configure_theme.sh && \
  /scripts/05_enable_services.sh && \
  /scripts/06_just.sh && \
  /scripts/07_cleanup.sh && \
  ostree container commit
