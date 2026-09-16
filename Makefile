all:
	$(MAKE) -C untether all
	$(MAKE) -C procyon all

clean:
	$(MAKE) -C untether clean
	$(MAKE) -C procyon clean
	@rm -rf ./procyon.tar
	@rm -rf ./staging

deb:
	@rm -rf ./staging
	@mkdir -p ./staging/DEBIAN
	@umask u=rwx,g=rx,o=rx && mkdir -p ./staging/usr/lib
	@umask u=rwx,g=rx,o=rx && mkdir -p ./staging/usr/bin

	@cp -a ./procyon/procyon ./staging/usr/bin/procyon
	@cp -a ./resources/control ./staging/DEBIAN/control
	@cp -a ./resources/postinst ./staging/DEBIAN/postinst
	@cp -a ./resources/prerm ./staging/DEBIAN/prerm

	@chmod 0755 ./staging/DEBIAN/prerm
	@chmod 0755 ./staging/DEBIAN/postinst
	@chmod 6755 ./staging/usr/bin/procyon
	@find ./staging -name '.DS_Store' -type f -delete
	dpkg-deb -Znone --root-owner-group --build ./staging ./com.staturnz.procyon_1.0_iphoneos-arm.deb

	@chmod 0755 ./com.staturnz.procyon_1.0_iphoneos-arm.deb
	@chown 501:20 ./com.staturnz.procyon_1.0_iphoneos-arm.deb
	@chmod -R 0755 ./staging
	@chown -R 501:20 ./staging

tar:
	@rm -rf ./staging
	@mkdir -p ./staging
	@umask u=rwx,g=rx,o=rx && mkdir -p ./staging/usr/bin
	@umask u=rwx,g=rx,o=rx && mkdir -p ./staging/usr/lib
	@cp -a ./procyon/procyon ./staging/usr/bin/procyon
	@chmod 0755 ./staging/usr/bin/procyon

	@find ./staging -name '.DS_Store' -type f -delete
	cd ./staging && COPYFILE_DISABLE=1 tar --numeric-owner -c --no-xattrs -f ../procyon.tar ./*
	@chmod 0755 ./procyon.tar
	@chown 501:20 ./procyon.tar
	@chmod -R 0755 ./staging
	@chown -R 501:20 ./staging

package: clean all deb tar

