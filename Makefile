all: tarball

tarball:
	./build.sh

clean:
	git clean -ffd

.PHONY: all tarball clean
