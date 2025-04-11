#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'
BOLD='\033[1m'

FILE1="/opt/umbreld/source/modules/files/external-storage.ts"
FILE2="/opt/umbreld/source/modules/is-umbrel-home.ts"

PATCHED1=false
PATCHED2=false

echo -e "${BLUE}${BOLD}UmbrelOS External Storage Patch${NC}"
echo -e "${BLUE}===================================${NC}\n"

if grep -q "return await isUmbrelHome()" "$FILE1"; then
    sudo sed -i 's/return await isUmbrelHome()/return true/' "$FILE1"
    PATCHED1=true
    echo -e "${GREEN}[✓] $FILE1 successfully patched${NC}"
elif grep -q "return true" "$FILE1"; then
    echo -e "${YELLOW}[!] $FILE1 is already patched${NC}"
else
    echo -e "${RED}[✗] Target string not found in $FILE1${NC}"
fi

if grep -q "return manufacturer === 'Umbrel, Inc.' && model === 'Umbrel Home'" "$FILE2"; then
    sudo sed -i "s/return manufacturer === 'Umbrel, Inc.' && model === 'Umbrel Home'/return true/" "$FILE2"
    PATCHED2=true
    echo -e "${GREEN}[✓] $FILE2 successfully patched${NC}"
elif grep -q "return true" "$FILE2"; then
    echo -e "${YELLOW}[!] $FILE2 is already patched${NC}"
else
    echo -e "${RED}[✗] Target string not found in $FILE2${NC}"
fi

if $PATCHED1 || $PATCHED2; then
    echo -e "\n${GREEN}${BOLD}[✓] Patch applied successfully${NC}"
    echo -e "${GREEN}Tauz nods approvingly${NC}"
    
    echo -e "\n${BLUE}System will reboot in 5 seconds${NC}"
    echo -e "${YELLOW}Press Ctrl+C to cancel...${NC}"

    for i in {5..1}; do
        echo -ne "${RED}${BOLD}$i ${NC}"
        sleep 1
    done

    echo -e "\n\n${BLUE}${BOLD}Rebooting system...${NC}"
    sudo reboot
else
    echo -e "\n${YELLOW}[!] No changes made${NC}"
    echo -e "${YELLOW}Everything is already done or strings not found${NC}"
    echo -e "${GREEN}No reboot required${NC}"
fi 
