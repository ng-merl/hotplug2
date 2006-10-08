# vim:set sw=8 nosta:

CFLAGS=-Os -DHAVE_RULES -Wall -g
LDFLAGS=-g

INSTALL=install -c -m 644
INSTALL_BIN=install -c -m 755


.PHONY: all clean dep install install-recursive clean-recursive \
	dep-recursive all-recursive

MAKEDEP=-gcc $(CFLAGS) -MM $(wildcard *.c *.cc) > .depend
dep: dep-recursive
	$(MAKEDEP)
.depend:
	$(MAKEDEP)
dep-recursive:
	@for i in $(SUBDIRS); do $(MAKE) -C $$i dep; done
	
-include .depend

clean: clean-recursive
	$(RM) $(wildcard *.o *.so *.a $(BINS)) .depend
clean-recursive:
	@for i in $(SUBDIRS); do $(MAKE) -C $$i clean; done

all: all-recursive
all-recursive:
	@for i in $(SUBDIRS); do $(MAKE) -C $$i all; done

install: all install-recursive
install-recursive:
	@for i in $(SUBDIRS); do $(MAKE) -C $$i install; done
