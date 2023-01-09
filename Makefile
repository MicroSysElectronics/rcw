DESTDIR = .
BOARDS = mpxls1028 mpxls1088 mpxls1046 mpxls1043 master5 comels1046a mpxlx2160a

VER = $(shell git describe --tags)

all install clean:
	@for board in $(BOARDS); do \
		$(MAKE) -C $$board $@ DESTDIR=$(DESTDIR)/$$board; \
	done

release: $(foreach board,$(BOARDS),rcw-$(board)-$(VER).tar.gz)

$(foreach board,$(BOARDS),rcw-$(board)-$(VER).tar.gz): rcw-%-$(VER).tar.gz:
	git archive --format=tar HEAD --prefix rcw- $* | gzip -9 > $@

.PHONY: all install clean release $(foreach board,$(BOARDS),rcw-$(board)-$(VER).tar.gz)
