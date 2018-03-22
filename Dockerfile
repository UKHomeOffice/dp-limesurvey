FROM ubuntu:trusty
LABEL maintainer="leigh.anderson@digital.homeoffice.gov.uk"

RUN apt update && apt install -y php5 php5-mysql curl

RUN ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log
RUN chown -R www-data /var/log/apache2
RUN chown -R www-data /var/run/apache2
RUN rm /var/www/html/index.html && touch /var/www/html/foo
COPY files/000-default.conf /etc/apache2/sites-available
COPY files/ports.conf /etc/apache2

RUN curl https://download.limesurvey.org/latest-stable-release/limesurvey3.5.4+180320.tar.bz2 | \
    tar jx --strip-components 1 -C /var/www/html

RUN chown -R www-data:www-data /var/www/html/tmp /var/www/html/upload /var/www/html/application/config
VOLUME /var/www/html/tmp
VOLUME /var/www/html/upload
VOLUME /var/www/application/config

# www-data:www-data
USER 33:33
EXPOSE 10080
CMD apache2ctl -DFOREGROUND
