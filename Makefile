LIST:=usb-creator-gtk cloud-image-utils gnome-disk-utility whois ansible-core git

bootusb: LIST:=efibootmgr
OPTS:= --diff

alt%:  OPTS+= -e alt=$@.yaml
view check:  OPTS+= --check

iso alt1: packages pull
	ansible-playbook $(OPTS) iso.yaml
	@echo
	@echo "Insert a key for the cloud-init , then answer y ( or n to skip )"
	@echo
	-@echo "/tmp/nocloud-usb.sh" | xargs -r -n1 -p bash
	@echo
	@echo "Insert a key for the iso, then answer y ( or n to skip )"
	@echo
	-@echo "/tmp/media-usb.sh" | xargs -r -n1 -p bash

alt%: packages pull
	ansible-playbook $(OPTS) iso.yaml
	@echo
	@echo "Insert a key for the cloud-init , then answer y  ( or n to skip )"
	@echo
	-@echo "/tmp/nocloud-usb.sh" | xargs -r -n1 -p bash
	@echo
	@echo "Insert a key for the iso, then answer y ( or n to skip )"
	@echo
	-@echo "/tmp/media-usb.sh" | xargs -r -n1 -p bash


view check config guest: pull
	-ansible-playbook $(OPTS) config.yaml

subiquity:
	git clone https://github.com/canonical/subiquity.git

subiquity/scripts/validate-autoinstall-user-data.py: subiquity
	make -C subiquity install_deps

parse: subiquity/scripts/validate-autoinstall-user-data.py 
	cat /tmp/cidata/user-data | subiquity/scripts/validate-autoinstall-user-data.py

clean:
	-rm -fr subiquity

pull:
	@git pull


$(LIST):
	@dpkg -s $@ 2>/dev/null |  grep "Status: install" || sudo apt install -y $@

packages: $(LIST)
	@echo $@



scratch: pull
	-pkill -u scratch
	find ~scratch -maxdepth 1 -mindepth 1 -exec rm -fr {} \;
	test -f /root/cloud-init.sh && flock -x  /tmp/robot /bin/bash  /root/cloud-init.sh


bootusb: # packages # PXE may fail - USB will follow
	-@make  packages LIST=efibootmgr
	@efibootmgr | perl -n -e'!/USB/ && /HD/ && /Boot([\dA-F]+)/ && print "$$1\n"' | xargs  -I{} -r -p efibootmgr -b {} -B
	@echo "Attention-u-are-about-to-reboot-4-reinstall" | xargs  -I{} -p -r shutdown -r   now {}
