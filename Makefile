# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agerbaud <agerbaud@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/22 19:27:59 by agerbaud          #+#    #+#              #
#    Updated: 2025/05/25 16:12:01 by agerbaud         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = PmergeMe

SRCS =	sources/main.cpp		\
		sources/PmergeMe.cpp

CXX = c++
CFLAGS = -Wall -Wextra -Werror -MMD -std=c++98

SECRET_DIR = .SECRET
CERT_FILE = $(SECRET_DIR)/certificate.crt
KEY_FILE = $(SECRET_DIR)/private_key.key

OBJECTS = $(SRCS:.cpp=.o)
DEPENDENCIES = $(SRCS:.cpp=.d)


LOGIN = agerbaud
DOMAIN = $(LOGIN).42.fr


all: $(NAME)

$(NAME): $(OBJECTS)
	$(CXX) $(CFLAGS) -o $@ $^

-include $(DEPENDENCIES)

%.o: %.cpp
	$(CXX) $(CFLAGS) -o $@ -c $<

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


.PHONY: all clean fclean re
