FROM composer:2.6
RUN apk --no-cache add patch freetype-dev libjpeg-turbo-dev libpng-dev icu-dev && docker-php-ext-configure gd \
  --with-freetype \
  --with-jpeg \
  && docker-php-ext-install bcmath \
  && docker-php-ext-install gd \
  && docker-php-ext-install intl \
  && docker-php-ext-install mysqli
# The base image sets COMPOSER_HOME=/tmp. The greenkite docker-compose mounts
# the host's composer package cache over /tmp at runtime, which would hide any
# global config baked into /tmp. Move COMPOSER_HOME to a dedicated directory
# that is not volume-mounted, and point COMPOSER_CACHE_DIR back to /tmp so the
# existing package cache behaviour is preserved.
ENV COMPOSER_HOME=/composer-home
ENV COMPOSER_CACHE_DIR=/tmp
# Pre-approve the standard Drupal Composer plugins so that non-interactive
# installs succeed on a clean vendor directory (Composer 2.2+ requires explicit
# allow-plugins consent and raises PluginBlockedException when the check fires
# before the project config is available during fresh plugin installation).
RUN composer config --global allow-plugins.composer/installers true \
  && composer config --global allow-plugins.cweagans/composer-patches true
WORKDIR /app
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["composer"]
