PREFIX ?= /usr

all:

install:
	mkdir -p $(DESTDIR)$(PREFIX)/share
	cp -R \
		aurorae \
		color-schemes \
		konsole \
		Kvantum \
		plasma \
		wallpapers \
		yakuake \
		$(DESTDIR)$(PREFIX)/share

uninstall:
	-rm -rf $(DESTDIR)$(PREFIX)/share/aurorae/themes/Adapta
	-rm -r  $(DESTDIR)$(PREFIX)/share/color-schemes/Adapta.colors
	-rm -r  $(DESTDIR)$(PREFIX)/share/color-schemes/AdaptaNokto.colors
	-rm -r  $(DESTDIR)$(PREFIX)/share/konsole/Adapta.colorscheme
	-rm -r  $(DESTDIR)$(PREFIX)/share/konsole/AdaptaNokto.colorscheme
	-rm -rf $(DESTDIR)$(PREFIX)/share/Kvantum/Adapta
	-rm -rf $(DESTDIR)$(PREFIX)/share/Kvantum/AdaptaNokto
	-rm -rf $(DESTDIR)$(PREFIX)/share/plasma/desktoptheme/Adapta
	-rm -rf $(DESTDIR)$(PREFIX)/share/plasma/look-and-feel/com.github.varlesh.adapta
	-rm -rf $(DESTDIR)$(PREFIX)/share/wallpapers/Adapta
	-rm -rf $(DESTDIR)$(PREFIX)/share/yakuake/skins/adapta
	-rm -rf $(DESTDIR)$(PREFIX)/share/yakuake/skins/adapta-nokto

_get_version:
	$(eval VERSION := $(shell git show -s --format=%cd --date=format:%Y%m%d HEAD))
	@echo $(VERSION)

release: _get_version push
	git tag -f $(VERSION)
	git push origin --tags

undo_release: _get_version
	-git tag -d $(VERSION)
	-git push --delete origin $(VERSION)


.PHONY: all install uninstall _get_version release undo_release