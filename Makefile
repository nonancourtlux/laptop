LIST:=usb-creator-gtk cloud-image-utils gnome-disk-utility whois ansible-core git

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


view check:
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
