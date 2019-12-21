FROM cardboardci/ci-core:focal
USER root

ARG DEBIAN_FRONTEND=noninteractive

COPY provision/pkglist /cardboardci/pkglist
RUN apt-get update \
    && xargs -a /cardboardci/pkglist apt-get install -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY provision/gemlist /cardboardci/gemlist
RUN xargs -a /cardboardci/gemlist gem install 

USER cardboardci

##
## Image Metadata
##
ARG build_date
ARG version
ARG vcs_ref
LABEL maintainer="CardboardCI"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="rubocop"
LABEL org.label-schema.version="${version}"
LABEL org.label-schema.build-date="${build_date}"
LABEL org.label-schema.release="CardboardCI version:${version} build-date:${build_date}"
LABEL org.label-schema.vendor="cardboardci"
LABEL org.label-schema.architecture="amd64"
LABEL org.label-schema.summary="Ruby static code analyzer"
LABEL org.label-schema.description="A Ruby static code analyzer and formatter, based on the community Ruby style guide"
LABEL org.label-schema.url="https://gitlab.com/cardboardci/images/rubocop"
LABEL org.label-schema.changelog-url="https://gitlab.com/cardboardci/images/rubocop/releases"
LABEL org.label-schema.authoritative-source-url="https://cloud.docker.com/u/cardboardci/repository/docker/cardboardci/rubocop"
LABEL org.label-schema.distribution-scope="public"
LABEL org.label-schema.vcs-type="git"
LABEL org.label-schema.vcs-url="https://gitlab.com/cardboardci/images/rubocop"
LABEL org.label-schema.vcs-ref="${vcs_ref}"