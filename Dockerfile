FROM composer:1.6
RUN apk --no-cache add patch && docker-php-ext-install gd
WORKDIR /app
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["composer"]
