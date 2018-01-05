FROM composer:1.6
RUN apk --no-cache add patch
WORKDIR /app
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["composer"]
