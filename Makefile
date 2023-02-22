postgres:
	docker run --name simplebank-postgres-1 -p 8081:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d --rm  postgres:15-bullseye

createdb:
	docker exec -it simplebank-postgres-1 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it simplebank-postgres-1 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:8081/simple_bank?sslmode=disable" -verbose up

migrateup1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:8081/simple_bank?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:8081/simple_bank?sslmode=disable" -verbose down

migratedown1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:8081/simple_bank?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/pizhlo/go-simple-bank/db/sqlc Store

.PHONY: postgres createdb dropdb migrateup migratedown migrateup1 migratedown1 sqlc test server mock