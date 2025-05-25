# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agerbaud <agerbaud@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/23 15:14:33 by agerbaud          #+#    #+#              #
#    Updated: 2025/05/23 16:37:13 by agerbaud         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM    debian:bullseye

EXPOSE	3306

RUN     apt-get update
RUN     apt-get upgrade -y

RUN     apt-get -y install mariadb-server

CMD     ["cat"]
