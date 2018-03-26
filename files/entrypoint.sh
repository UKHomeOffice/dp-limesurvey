#!/usr/bin/env bash

tar jxf /limesurvey.tar.bz2 --strip-components 1 -C /var/www/html

apache2ctl -DFOREGROUND
