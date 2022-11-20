### Verify storage

```
sudo df -h
show system image storage
```

### Delete backup system image (not runniung image)
```delete system image```


### Current firmware version
```show version```

### Add image from URL
```add system image htttp://dl.ubnt.com/something/firmware.tar```

### Add image from other sources
```add system image tftp://ip-address/firmware.tar```
```add system image scp://ip-address/firmware.tar```
```add system image ftp://ip-address/firmware.tar```

### Verify default new image
```show system image```

Use the ```set system image default-boot``` command to swap the boot images if needed.


Commands taken from https://help.ui.com/hc/en-us/articles/205146110-EdgeMAX-Upgrading 
