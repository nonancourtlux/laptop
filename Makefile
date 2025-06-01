LIST:=usb-creator-gtk cloud-image-utils gnome-disk-utility whois ansible-core git


master: packages
	ansible-playbook master.yaml


$(LIST):
	@dpkg -s $@ 2>/dev/null |  grep "Status: install" || sudo apt install -y $@

packages: $(LIST)
	@echo $@ 
