# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agerbaud <agerbaud@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/23 15:14:33 by agerbaud          #+#    #+#              #
#    Updated: 2025/06/25 12:53:28 by agerbaud         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM    debian:bullseye

EXPOSE	3306

RUN     apt-get update
RUN     apt-get upgrade -y

RUN     apt-get -y install mariadb-server
RUN		mkdir -p /run/mysqld
RUN		chown mysql:mysql /run/mysqld

COPY	./tools/install-mariadb.sh /usr/local/bin/
RUN		chmod +x /usr/local/bin/install-mariadb.sh

CMD		["/usr/local/bin/install-mariadb.sh"]
