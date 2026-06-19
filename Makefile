SHELL := /usr/bin/env bash

PREFIX ?= $(HOME)/.local
BINDIR := $(PREFIX)/bin
TEXT_FILES := bin install.sh .github docs README.md TASK_SPEC.md CHANGELOG.md Makefile .gitattributes

.PHONY: install uninstall lint check-line-endings

install:
	mkdir -p "$(BINDIR)"
	install -m 0755 bin/sss "$(BINDIR)/sss"
	install -m 0755 bin/sss-snake "$(BINDIR)/sss-snake"
	@echo "Installed to $(BINDIR)"

uninstall:
	rm -f "$(BINDIR)/sss" "$(BINDIR)/sss-snake"
	@echo "Uninstalled from $(BINDIR)"

check-line-endings:
	@if grep -RIl $$'\r' $(TEXT_FILES); then \
		echo "CRLF line endings found. Use LF for shell scripts and project text files." >&2; \
		exit 1; \
	fi

lint: check-line-endings
	bash -n bin/sss bin/sss-snake install.sh
	shellcheck bin/sss bin/sss-snake install.sh