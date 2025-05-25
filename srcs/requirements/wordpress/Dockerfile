# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agerbaud <agerbaud@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/23 15:14:09 by agerbaud          #+#    #+#              #
#    Updated: 2025/05/23 15:14:10 by agerbaud         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM    debian:bullseye

EXPOSE	9000

RUN     apt-get update
RUN     apt-get upgrade -y

RUN     apt-get -y install curl
RUN     apt-get -y install php
RUN     apt-get -y install php-cli
RUN     apt-get -y install php-fpm
RUN     apt-get -y install wget
RUN     apt-get -y install wordpress

RUN		curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN	    chmod +x wp-cli.phar
RUN		mv wp-cli.phar /usr/local/bin/wp
RUN		wp core download --allow-root
RUN	    #wp config create --dbname=mariadb --dbuser=root --dbpass=coucou --dbhost=mariadb --allow-root


CMD     ["cat"]
