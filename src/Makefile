all:

install: all
	# install to sbin since script only usable by root
	install -D -m 755 mkiso $(DESTDIR)/usr/bin/mkiso
	install -D -m 755 buildiso $(DESTDIR)/usr/bin/buildiso
	# testiso can be used by anyone
	install -D -m 755 testiso $(DESTDIR)/usr/bin/testiso
	# hooks/install are needed by mkinitcpio
	install -D -m 644 hooks/miso $(DESTDIR)/usr/lib/initcpio/hooks/miso
	install -D -m 644 install/miso $(DESTDIR)/usr/lib/initcpio/install/miso
	install -D -m 644 hooks/miso_pxe_nbd $(DESTDIR)/usr/lib/initcpio/hooks/miso_pxe_nbd
	install -D -m 644 install/miso_pxe_nbd $(DESTDIR)/usr/lib/initcpio/install/miso_pxe_nbd
	install -D -m 644 hooks/miso_loop_mnt $(DESTDIR)/usr/lib/initcpio/hooks/miso_loop_mnt
	install -D -m 644 install/miso_loop_mnt $(DESTDIR)/usr/lib/initcpio/install/miso_loop_mnt
	install -D -m 644 install/miso_kms $(DESTDIR)/usr/lib/initcpio/install/miso_kms
	# install configs, docs and examples
	install -D -m 755 functions/messages $(DESTDIR)/usr/share/manjaroiso/functions/messages
	install -D -m 644 ../README $(DESTDIR)/usr/share/doc/manjaroiso/README

uninstall:
	rm -f $(DESTDIR)/usr/bin/mkiso
	rm -f $(DESTDIR)/usr/bin/buildiso
	rm -f $(DESTDIR)/usr/bin/testiso
	rm -f $(DESTDIR)/usr/lib/initcpio/hooks/miso
	rm -f $(DESTDIR)/usr/lib/initcpio/install/miso
	rm -f $(DESTDIR)/usr/lib/initcpio/hooks/miso_pxe_nbd
	rm -f $(DESTDIR)/usr/lib/initcpio/install/miso_pxe_nbd
	rm -f $(DESTDIR)/usr/lib/initcpio/hooks/miso_loop_mnt
	rm -f $(DESTDIR)/usr/lib/initcpio/install/miso_loop_mnt
	rm -f $(DESTDIR)/usr/lib/initcpio/install/miso_kms
	rm -rf $(DESTDIR)/usr/share/manjaroiso/
	rm -rf $(DESTDIR)/usr/share/doc/manjaroiso/
