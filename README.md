# es8336-dkms-debian
ES8336 DKMS module for Debian kernels

Requires ```Kernel 5.19``` or higher

Install ```linux-headers-amd64```

```sudo make dkmsinstall```

Enable module or restart

```sudo modprobe sof_es8336```
