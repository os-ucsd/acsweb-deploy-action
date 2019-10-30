FROM alpine:3.10

LABEL version="1.0.0"
LABEL repository="https://github.com/os-ucsd/actions"
LABEL homepage="https://github.com/os-ucsd/actions"
LABEL maintainer="Alex Garcia <asg017@ucsd.edu>"

LABEL "com.github.actions.name"="UCSD ACSWeb Site Deploy"
LABEL "com.github.actions.description"="Sync your personal website to your acsweb.ucsd.edu site"
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="blue"

RUN apk update
RUN apk add --update --no-cache openssh sshpass rsync


COPY entrypoint.sh /entrypoint.sh
RUN chmod 777 entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
