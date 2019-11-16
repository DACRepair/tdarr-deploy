FROM alpine:3.10

ENV MONGO_URL=mongodb://mongodb:27017/tdarr
ENV PORT=8265
ENV ROOT_URL=http://0.0.0.0/
ENV NODE_ARGS="--max-old-space-size=4096"

ENV PGID=999
ENV PUID=999

# Setup
RUN apk add --no-cache \
        p7zip \
        git \
        exiftool \
	nodejs \
	unzip \
        wget \
    && apk add --no-cache --repository="http://dl-cdn.alpinelinux.org/alpine/edge/testing" \
        ffmpeg \
        handbrake \
        handbrake-gtk

WORKDIR /app
RUN wget https://github.com/HaveAGitGat/Tdarr/releases/download/v1.006-Alpha/Tdarr-Linux-v1.006-Alpha.7z \
    && p7zip -d Tdarr-Linux-v1.006-Alpha.7z

# Run
EXPOSE 8265
WORKDIR /app/Tdarr/bundle
# CMD /bin/sleep 1d
CMD ["node","main.js", "NODE_ARGS"] 
