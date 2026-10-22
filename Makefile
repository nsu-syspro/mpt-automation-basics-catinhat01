name = $(shell jq -r .name config.json)
vers = $(shell jq -r .version config.json)

flag   = -D NAME=\"$(name)\" -D VERSION=\"$(vers)\"
target = build/$(name)

tests  = $(wildcard test/*.txt)
checks = $(tests:.txt=.check)

all: $(target)

$(target): src/wordcount.c config.json
	mkdir -p build
	gcc $(flag) src/wordcount.c -o $(target)

clean:
	rm -rf build
check: $(checks)

$(checks): %.check: %.txt %.expected $(target)
	@$(target) $< | diff -u $*.expected -
