#!/bin/bash

# ==========================================
# 🚀 UMBREL HOME TRANSFORMATION PROTOCOL 🚀
# ==========================================
# Author: @mffff4
# GitHub: https://github.com/mffff4
# ==========================================

CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "\n${MAGENTA}/// INITIATING PROTOCOL @mffff4 ///${NC}"
echo -e "${CYAN}Target:${NC} Transform Raspberry Pi into Elite Umbrel Home."
echo -e "${CYAN}Status:${NC} Loading reality exploits..."
sleep 2

# --- VARS ---
SRC_DIR="/opt/umbreld/source/modules"
F_HOME="$SRC_DIR/is-umbrel-home.ts"
F_SYS="$SRC_DIR/system/system.ts"
F_MIG="$SRC_DIR/migration/migration.ts"
F_EXT="$SRC_DIR/files/external-storage.ts"

# --- 1. BACKUP ---
BACKUP_DIR="/home/umbrel/backup_$(date +%Y%m%d_%H%M%S)"
echo -e "\n${CYAN}[1/5] 💾 Creating Restore Point (Backup)...${NC}"
mkdir -p "$BACKUP_DIR"

safe_backup() {
    if [ -f "$1" ]; then
        cp "$1" "$BACKUP_DIR/"
        echo -e "   -> Saved: $(basename "$1")"
    else
        echo -e "   ${RED}-> Error: File $1 not found!${NC}"
        exit 1
    fi
}

safe_backup "$F_HOME"
safe_backup "$F_SYS"
safe_backup "$F_MIG"
safe_backup "$F_EXT"
echo -e "${GREEN}>> Backups secured in: $BACKUP_DIR${NC}"

# --- 2. SPOOF IDENTITY ---
echo -e "\n${CYAN}[2/5] 🕵️‍♂️ Injecting False Memories (Spoofing Identity)...${NC}"

# Force is-umbrel-home check to true
sudo sed -i "s/return manufacturer === 'Umbrel, Inc.' && model === 'Umbrel Home'/return true/" "$F_HOME"
echo -e "   -> We are now officially 'Umbrel Home'."

# Inject fake model U130121
if ! grep -q "model = 'U130121'" "$F_SYS"; then
    sudo sed -i "/export const getSystemInfo = async () => {/a \\    model = 'U130121'; productName = 'Umbrel Home'; manufacturer = 'Umbrel, Inc.';" "$F_SYS"
fi

# Remove blanking logic
sudo sed -i "/if (productName !== 'Umbrel Home' && productName !== 'Umbrel Pro') {/,+3d" "$F_SYS"

# Spoof CPU info
sudo sed -i "s|const cpuInfo = await fse.readFile('/proc/cpuinfo')|const cpuInfo = 'Generic Intel CPU'; // HACKED BY @mffff4|" "$F_SYS"

# Disable WiFi restore loop
if ! grep -q "return; // PATCHED" "$F_SYS"; then
    sudo sed -i "/export async function restoreWiFi(umbreld: Umbreld): Promise<void> {/a \\    return; // PATCHED: No Loop" "$F_SYS"
fi
echo -e "${GREEN}>> Identity successfully spoofed.${NC}"

# --- 3. UNLOCK FEATURES ---
echo -e "\n${CYAN}[3/5] 🔓 Bypassing Migration & Storage Locks...${NC}"

# Remove migration error
sudo sed -i "s/throw new Error('This feature is only supported on Umbrel Home hardware')/\/\/ Error removed by @mffff4/" "$F_MIG"

# Force external storage support
sudo sed -i "s/const isNotRaspberryPi = !(await isRaspberryPi())/const isNotRaspberryPi = true/" "$F_EXT"
sudo sed -i "s/return await isUmbrelHome()/return true/" "$F_EXT"

echo -e "${GREEN}>> All restrictions removed.${NC}"

# --- 4. CLEANUP ---
echo -e "\n${CYAN}[4/5] 🧹 Cleaning Evidence (Hiding SD partitions)...${NC}"

# Restore USB filter
if grep -q "return blockDevices;" "$F_EXT"; then
     sudo sed -i "s|return blockDevices;|return blockDevices.filter((device) => device.transport === 'usb')|" "$F_EXT"
fi

# Unmount ghosts
sudo umount -f /home/umbrel/umbrel/external/BOOT* 2>/dev/null
sudo umount -f /home/umbrel/umbrel/external/CONFIG 2>/dev/null
sudo rm -rf /home/umbrel/umbrel/external/BOOT* 2>/dev/null
echo -e "${GREEN}>> File system clean.${NC}"

# --- 5. FINISH ---
echo -e "\n${MAGENTA}========================================${NC}"
echo -e "${GREEN}✨ OPERATION SUCCESSFUL ✨${NC}"
echo -e "${MAGENTA}========================================${NC}"

echo -e "${CYAN}🔄 Restarting Umbrel Services...${NC}"
sudo systemctl restart umbrel

echo -e "${GREEN}>> Done. Welcome to Umbrel Home.${NC}"
echo -e "P.S. Backups are in $BACKUP_DIR"
echo -e "By @mffff4 | github.com/mffff4"


