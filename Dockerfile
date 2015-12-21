FROM alpine:3.2
MAINTAINER Calvin Leung Huang <https://github.com/cleung2010>

ENV NOMAD_VERSION 0.2.3
ENV NOMAD_SHA256 0f3a7083d160893a291b5f8b4359683c2df7991fa0a3e969f8785ddb40332a8c

# Add Nomad binary
ADD https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip /tmp/nomad.zip

# Install Nomad and create optional config folder to be used
RUN echo "${NOMAD_SHA256}  /tmp/nomad.zip" > /tmp/nomad.sha256 \
    && sha256sum -c /tmp/nomad.sha256 \
    && unzip /tmp/nomad.zip -d /usr/bin \
    && chmod +x /usr/bin/nomad \
    && rm /tmp/nomad.zip \
    && mkdir /etc/nomad.d \
    && chmod a+w /etc/nomad.d

# Expose Nomad-related ports
EXPOSE 4646 4647 4648 4648/udp

ENTRYPOINT ["/usr/bin/nomad"]