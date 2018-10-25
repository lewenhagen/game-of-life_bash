# target: validate
.PHONY:  validate
validate:
	shellcheck --shell=bash main.bash

# target: test
.PHONY:  test
test:
	./test.sh
