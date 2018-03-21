FROM ubuntu:trusty
LABEL maintainer="leigh.anderson@digital.homeoffice.gov.uk"

RUN apt update && apt install -y php5 php5-mysql curl

RUN ln -s /dev/stdout /var/log/apache2/access_log && \
    ln -s /dev/stderr /var/log/apache2/error_log
RUN rm /var/www/html/index.html && touch /var/www/html/foo

RUN curl https://download.limesurvey.org/latest-stable-release/limesurvey3.5.4+180320.tar.bz2 | \
    tar jx --strip-components 1 -C /var/www/html

RUN chown -R www-data:www-data /var/www/html/tmp /var/www/html/upload /var/www/html/application/config
VOLUME /var/www/html/tmp
VOLUME /var/www/html/upload
VOLUME /var/www/application/config

CMD apache2ctl -DFOREGROUND
