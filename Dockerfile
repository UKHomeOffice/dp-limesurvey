FROM ubuntu:trusty
LABEL maintainer="leigh.anderson@digital.homeoffice.gov.uk"

RUN apt update && apt install -y php5 php5-mysql curl

RUN ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log
RUN chown -R www-data /var/log/apache2
RUN chown -R www-data /var/run/apache2
RUN rm /var/www/html/index.html
COPY files/000-default.conf files/default-ssl.conf /etc/apache2/sites-available/
COPY files/ports.conf /etc/apache2
COPY files/entrypoint.sh /usr/bin
RUN a2enmod ssl && a2enmod reqtimeout && a2enmod headers && a2ensite default-ssl

RUN curl -o /limesurvey.tar.bz2 https://download.limesurvey.org/latest-stable-release/limesurvey3.9.0+180604.tar.bz2
RUN mkdir -p /var/www/html/tmp && \
    mkdir -p /var/www/html/upload && \
    mkdir -p /var/www/html/application/config
RUN chown -R www-data /var/www/html

# www-data:www-data
USER 33:33
EXPOSE 10080
EXPOSE 10443
CMD entrypoint.sh
