# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jdhallen <jdhallen@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/05 12:54:14 by jdhallen          #+#    #+#              #
#    Updated: 2025/05/05 12:58:08 by jdhallen         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DC = docker compose -f srcs/docker-compose.yml

.PHONY: all up down clean re logs

all: up

up:
	$(DC) up --build -d

down:
	$(DC) down

clean:
	$(DC) down -v --rmi all

re: clean all

logs:
	$(DC) logs -f
