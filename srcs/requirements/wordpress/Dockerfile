# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agerbaud <agerbaud@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/23 15:14:09 by agerbaud          #+#    #+#              #
#    Updated: 2025/07/30 18:33:32 by agerbaud         ###   ########.fr        #
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

COPY	./tools/install-wordpress.sh /usr/local/bin/
RUN		chmod +x /usr/local/bin/install-wordpress.sh

CMD		["/usr/local/bin/install-wordpress.sh"]
