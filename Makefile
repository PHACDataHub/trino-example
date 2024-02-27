up: 
	docker compose build && docker compose up > docker-compose.log 2>&1

down: 
	docker compose down -v

make trino:
	docker exec -it trino trino