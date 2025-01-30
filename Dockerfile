FROM condaforge/mambaforge:latest

# For opencontainers label definitions, see:
#    https://github.com/opencontainers/image-spec/blob/master/annotations.md
LABEL org.opencontainers.image.title="opera_tropo"
LABEL org.opencontainers.image.description=""
LABEL org.opencontainers.image.authors="Marin Govorcin<marin.govorcin@jpl.nasa.gov>"
LABEL org.opencontainers.image.licenses="Apache-2.0"
LABEL org.opencontainers.image.url="https://github.com/opera-adt/opera_tropo"
LABEL org.opencontainers.image.source="https://github.com/opera-adt/opera_tropo"
LABEL org.opencontainers.image.documentation="https://github.com/opera-adt/opera_tropo"

# Dynamic lables to define at build time via `docker build --label`
# LABEL org.opencontainers.image.created=""
# LABEL org.opencontainers.image.version=""
# LABEL org.opencontainers.image.revision=""

ARG DEBIAN_FRONTEND=noninteractive
ENV PYTHONDONTWRITEBYTECODE=true

RUN apt-get update && apt-get install -y --no-install-recommends git unzip vim && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create non-root user/group with default inputs
ARG CONDA_UID=1000
ARG CONDA_GID=1000

RUN groupadd -g "${CONDA_GID}" --system tropo && \
    useradd -l -u "${CONDA_UID}" -g "${CONDA_GID}" --system -d /home/tropo -m  -s /bin/bash tropo && \
    chown -R tropo:tropo /opt

USER ${CONDA_UID}
WORKDIR /home/tropo
SHELL ["/bin/bash", "-l", "-c"]

COPY --chown=${CONDA_UID}:${CONDA_GID} . /opera_tropo/

RUN mamba env create -f /opera_tropo/conda-env.yml && \
    conda clean -afy

# Ensure that environment is activated on startup
RUN echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.profile && \
    echo "conda activate opera_tropo" >> ~/.profile

RUN python -m pip install --no-cache-dir /RAiDER/

ENTRYPOINT ["/RAiDER/tools/RAiDER/etc/entrypoint.sh"]
CMD ["--help"]