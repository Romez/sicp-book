SHELL:=/bin/zsh

repl:
	racket

test:
	raco test ./src/**/*-test.rkt
