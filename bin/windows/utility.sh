#
#Jancox-tool
#By wahyu6070

#
edit=./editor
rominfo=$edit/rom.info

#functions
print(){
	echo "$1"
}
getprop() { grep "$1" "$2" | cut -d "=" -f 2; }

#
#
if [ -d $edit/system/system ]; then
system=system/system
systemroot=true
else
system=system
systemroot=false
fi;

#
case $1 in
rom-info)
if [ $(grep -q secure=0 $edit/vendor/default.prop) ]; then dmverity=true;
elif [ $(grep forceencrypt $edit/vendor/etc/fstab.qcom) ]; then dmverity=true;
elif [ $(grep forcefdeorfbe $edit/vendor/etc/fstab.qcom) ]; then dmverity=true;
elif [ $(grep fileencryption $edit/vendor/etc/fstab.qcom) ]; then dmverity=true;
elif [ $(grep .dmverity=true $edit/vendor/etc/fstab.qcom) ]; then dmverity=true;
elif [ $(grep fileencryption $edit/vendor/etc/fstab.qcom) ]; then dmverity=true;
#elif [ -f $edit/$system/recovery-from-boot.p ]; then dmverity=true;
else
dmverity=false
fi;
echo "- Android Version = $(getprop ro.build.version.release $edit/$system/build.prop) "
echo "- Name ROM        = $(getprop ro.build.display.id $edit/$system/build.prop) "
echo "- Device          = $(getprop ro.product.vendor.device $edit/vendor/build.prop) "
echo "- System as-root  = $systemroot "
echo "- Dm-verity       = $dmverity "
;;
esac			
