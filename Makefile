PID_FILE=/tmp/go_id.pid

all: 

generate: 
	go run ./utils/generate/gen.go

install:

	go install ./...

test:
	go test ./pkg/lib/fieldgroups/...

clean: 
	rm ./pkg/lib/fieldgroups/*

# Used to bring up production container
run-local-prod:
	sudo podman build -t config-app:latest -f Dockerfile . && sudo podman run -p 7070:8080 -ti config-app:latest editor --configPath=/conf_mount --password=password

# Used to bring up dev container
build-local-dev:
	sudo podman build -t config-app:dev -f Dockerfile.dev

run-local-dev:
	sudo podman run -p 7070:8080 -v ./pkg/lib/editor/js:/jssrc/js -v ./pkg/lib/editor/editor.go:/jssrc/editor.go -v ./:/go/src/config-tool -v ./testdata:/conf_mount -ti config-app:dev

