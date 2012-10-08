@echo -off

for %m run (0 20)
    if exist fs%m:\EFI\miso\manjaro.efi then
        fs%m:
        cd fs%m:\EFI\miso
        echo "Launching Manjaro Linux ISO Kernel fs%m:\EFI\miso\manjaro.efi"
        vmlinuz.efi misobasedir=%INSTALL_DIR% misolabel=%MISO_LABEL% initrd=\EFI\miso\manjaro.img
    endif
endfor
