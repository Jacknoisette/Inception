# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jdhallen <jdhallen@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/05 12:54:14 by jdhallen          #+#    #+#              #
#    Updated: 2025/07/17 09:07:42 by jdhallen         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DC = docker compose -f srcs/docker-compose.yml

.PHONY: all up down clean re logs

all: up

up:
	sh srcs/directory_creation.sh
	$(DC) up --build -d

down:
	$(DC) down

clean:
	$(DC) down --rmi all

fclean:
	docker system prune -a

re: clean all

logs:
	$(DC) logs -f
