FROM composer:1.9
RUN apk --no-cache add patch freetype-dev libjpeg-turbo-dev libpng-dev && docker-php-ext-configure gd \
  --with-freetype \
  --with-jpeg \
  && docker-php-ext-install gd
WORKDIR /app
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["composer"]
