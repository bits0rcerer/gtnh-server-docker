FROM alpine AS builder

ADD https://downloads.gtnewhorizons.com/ServerPacks/GT_New_Horizons_2.6.0_Server_Java_17-21.zip /server.zip

WORKDIR /server

RUN unzip /server.zip
ADD https://cdn.modrinth.com/data/Jrmoreqs/versions/lrc13aHX/AdvancedBackups-forge-1.7.10-3.6.3.jar /server/mods/
ADD https://raw.githubusercontent.com/MommyHeather/AdvancedBackups/0f845c3c8c06d963c14456f60cb9f31d403072b8/src/main/resources/advancedbackups-properties.txt /server/AdvancedBackups.properties

ADD *.patch /
RUN apk add patch && ash -c 'for f in /*.patch; do patch -p1 -i $f; done'

FROM eclipse-temurin:21

COPY --from=builder --chown=1000:1000 /server /server
USER 1000:1000
WORKDIR /server
ADD entrypoint.sh .

ENV MEM=8G
EXPOSE 25565
VOLUME [ "/server/World" ]
VOLUME [ "/server/backups" ]
CMD [ "/server/entrypoint.sh" ]
