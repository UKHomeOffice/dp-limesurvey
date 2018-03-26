FROM ubuntu:trusty
LABEL maintainer="leigh.anderson@digital.homeoffice.gov.uk"

RUN apt update && apt install -y php5 php5-mysql curl

RUN ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log
RUN chown -R www-data /var/log/apache2
RUN chown -R www-data /var/run/apache2
RUN chown -R www-data /var/www/html
RUN rm /var/www/html/index.html && touch /var/www/html/foo
COPY files/000-default.conf /etc/apache2/sites-available
COPY files/ports.conf /etc/apache2
COPY files/entrypoint.sh /usr/bin

RUN curl -o /limesurvey.tar.bz2 https://download.limesurvey.org/latest-stable-release/limesurvey3.5.4+180320.tar.bz2

# www-data:www-data
USER 33:33
EXPOSE 10080
CMD entrypoint.sh
