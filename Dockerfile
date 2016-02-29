FROM debian:8

Maintainer Konstantin Jakobi <konstantin@jakobi.club>

ENV VERSION=latest

COPY install /install/
RUN /install/_install.sh

EXPOSE 80 443 9000

COPY run /run/
CMD /run/_run.sh
