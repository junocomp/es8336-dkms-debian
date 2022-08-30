# es8336-dkms is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this software.  If not, see <https://www.gnu.org/licenses/>.
#
obj-m :=	./src/sof_es8336.o

PWD := $(shell pwd)
KDIR := /lib/modules/$(shell uname -r)/build
CFLAGS = "-Wno-error=format-truncation"

all:
	make -C $(KDIR) M=$(PWD) modules

clean:
	make -C $(KDIR) M=$(PWD) clean

install:
	make -C $(KDIR) M=$(PWD) modules_install

# Package version and name from dkms.conf
VER := $(shell sed -n 's/^PACKAGE_VERSION=\([^\n]*\)/\1/p' dkms.conf 2>&1 /dev/null)
MODULE_NAME := $(shell sed -n 's/^PACKAGE_NAME=\([^\n]*\)/\1/p' dkms.conf 2>&1 /dev/null)

dkmsinstall:
	cp -R . /usr/src/$(MODULE_NAME)-$(VER)
	dkms install -m $(MODULE_NAME) -v $(VER)

dkmsremove:
	dkms remove -m $(MODULE_NAME) -v $(VER) --all
	rm -rf /usr/src/$(MODULE_NAME)-$(VER)


