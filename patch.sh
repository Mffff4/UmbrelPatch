#!/bin/bash

FILE1="/opt/umbreld/source/modules/files/external-storage.ts"
FILE2="/opt/umbreld/source/modules/is-umbrel-home.ts"

PATCHED1=false
PATCHED2=false

if grep -q "return await isUmbrelHome()" "$FILE1"; then
    sudo sed -i 's/return await isUmbrelHome()/return true/' "$FILE1"
    PATCHED1=true
elif grep -q "return true" "$FILE1"; then
    echo "[✓] $FILE1 is already patched."
else
    echo "[!] Target string not found in $FILE1"
fi

if grep -q "return manufacturer === 'Umbrel, Inc.' && model === 'Umbrel Home'" "$FILE2"; then
    sudo sed -i "s/return manufacturer === 'Umbrel, Inc.' && model === 'Umbrel Home'/return true/" "$FILE2"
    PATCHED2=true
elif grep -q "return true" "$FILE2"; then
    echo "[✓] $FILE2 is already patched."
else
    echo "[!] Target string not found in $FILE2"
fi

if $PATCHED1 || $PATCHED2; then
    echo -e "\n[✓] Patch applied successfully. Tauz nods approvingly."
else
    echo -e "\n[!] No changes made. Everything is already done or strings not found."
fi

echo -e "\nSystem will reboot in 5 seconds. Press Ctrl+C to cancel..."
for i in {5..1}; do
    echo -n "$i "
    sleep 1
done

echo -e "\nRebooting system..."
sudo reboot 