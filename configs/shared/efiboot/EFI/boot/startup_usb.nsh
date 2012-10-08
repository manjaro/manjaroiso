@echo -off

for %m run (0 20)
    if exist fs%m:\%INSTALL_DIR%\boot\x86_64\manjaroiso then
        fs%m:
        cd fs%m:\%INSTALL_DIR%\boot\x86_64
        echo "Launching Manjaro Linux USB Kernel fs%m:\%INSTALL_DIR%\boot\x86_64\manjaroiso"
        manjaroiso misobasedir=%INSTALL_DIR% misolabel=%MISO_LABEL% initrd=\%INSTALL_DIR%\boot\x86_64\manjaro.img
    endif
endfor
