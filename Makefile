PREFIX ?= $(HOME)/.local
BINDIR := $(PREFIX)/bin

.PHONY: install uninstall lint

install:
	mkdir -p "$(BINDIR)"
	install -m 0755 bin/sss "$(BINDIR)/sss"
	install -m 0755 bin/sss-snake "$(BINDIR)/sss-snake"
	@echo "Installed to $(BINDIR)"

uninstall:
	rm -f "$(BINDIR)/sss" "$(BINDIR)/sss-snake"
	@echo "Uninstalled from $(BINDIR)"

lint:
	bash -n bin/sss bin/sss-snake install.sh
	shellcheck bin/sss bin/sss-snake install.sh
