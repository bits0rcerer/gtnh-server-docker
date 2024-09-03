FROM alpine AS builder

ADD https://downloads.gtnewhorizons.com/ServerPacks/GT_New_Horizons_2.6.0_Server_Java_17-21.zip /server.zip

WORKDIR /server

RUN unzip /server.zip
ADD https://cdn.modrinth.com/data/Jrmoreqs/versions/lrc13aHX/AdvancedBackups-forge-1.7.10-3.6.3.jar /server/mods/
ADD AdvancedBackups.properties /server/config/
ADD https://github.com/GTNewHorizons/GTNH-Web-Map/releases/download/0.3.29/gtnh-web-map-0.3.29.jar /server/mods/

ADD *.patch /
RUN apk add patch && ash -c 'for f in /*.patch; do patch -p1 -i $f; done'

FROM eclipse-temurin:21

COPY --from=builder --chown=1000:1000 /server /server
USER 1000:1000
WORKDIR /server
ADD entrypoint.sh .

ENV MEM=8G
EXPOSE 25565
EXPOSE 8123
VOLUME [ "/server/World" ]
VOLUME [ "/server/backups" ]
CMD [ "/server/entrypoint.sh" ]
