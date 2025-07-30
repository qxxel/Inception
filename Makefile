# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agerbaud <agerbaud@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/22 19:27:59 by agerbaud          #+#    #+#              #
#    Updated: 2025/07/30 22:15:08 by agerbaud         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = inception

SECRET_DIR = .SECRET
CERT_FILE = $(SECRET_DIR)/certificate.crt
KEY_FILE = $(SECRET_DIR)/private_key.key

LOGIN = agerbaud
DOMAIN = $(LOGIN).42.fr

DOCKER_CMD = docker compose
DOCKER_CMP = srcs/docker-compose.yml

all: $(SECRET_DIR) up

build: $(SECRET_DIR)
	$(DOCKER_CMD) -f $(DOCKER_CMP) build

run: $(SECRET_DIR)
	$(DOCKER_CMD) -f $(DOCKER_CMP) up -d

stop:
	$(DOCKER_CMD) -f $(DOCKER_CMP) down

up: build run

clean:
	$(RM) $(OBJECTS) $(DEPENDENCIES)

fclean: clean
	$(RM) $(NAME)
	$(RM) $(SECRET_DIR)

re: fclean
	$(MAKE) all

$(SECRET_DIR):
	mkdir -p $(SECRET_DIR)
	openssl req -x509 \
		-newkey rsa:2048 \
		-keyout $(KEY_FILE) -out $(CERT_FILE) \
		-days 365 -nodes \
		-subj "/C=FR/ST=ARA/L=Lyon/O=42Lyon/OU=IT/CN=$(DOMAIN)"


.PHONY: all clean fclean re build run stop up
