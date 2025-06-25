# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agerbaud <agerbaud@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/22 19:28:15 by agerbaud          #+#    #+#              #
#    Updated: 2025/06/19 23:15:36 by agerbaud         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM    debian:bullseye

RUN     apt-get update
RUN     apt-get upgrade -y

RUN		apt-get install -y nginx

COPY	conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE  8080

CMD     ["nginx", "-g", "daemon off;"]
