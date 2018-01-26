.PHONY: terraform-provider-nrs test

VERSION = "0.2.0"

terraform-provider-nrs:
	go install github.com/gozer/terraform-provider-nrs/cmd/terraform-provider-nrs

test:
	go test -v github.com/gozer/terraform-provider-nrs/pkg/... \
		github.com/gozer/terraform-provider-nrs/cmd/...

create-release:
	rm -rf build releases
	mkdir -p build/terraform-provider-nrs/linux-amd64
	mkdir -p build/terraform-provider-nrs/darwin-amd64

	GOOS=linux GOARCH=amd64 go build -o build/terraform-provider-nrs/linux-amd64/terraform-provider-nrs \
		github.com/gozer/terraform-provider-nrs/cmd/terraform-provider-nrs

	GOOS=darwin GOARCH=amd64 go build -o build/terraform-provider-nrs/darwin-amd64/terraform-provider-nrs \
		github.com/gozer/terraform-provider-nrs/cmd/terraform-provider-nrs

	mkdir releases
	tar -C build -c terraform-provider-nrs | gzip -c > releases/terraform-provider-nrs-${VERSION}.tar.gz
