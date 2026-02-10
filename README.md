# 🔌 UmbrelOS External Storage Patch

> ⚡ Enable external storage support on your UmbrelOS device with a single command

## ✨ Features

- 🚀 Enables external storage detection
- 🔓 Bypasses Umbrel Home device check
- 🔄 Automatic system reboot after patching
- ⏱️ 5-second countdown with cancel option

## 🚀 Quick Start

Copy and paste this command into your terminal:

```bash
curl -sSL https://github.com/Mffff4/UmbrelPatch/raw/main/patch.sh | sudo bash
```

## 🔧 What's Under the Hood

The patch modifies two critical system files:

1. `/opt/umbreld/source/modules/files/external-storage.ts`
   ```typescript
   // Before
   return await isUmbrelHome()
   
   // After
   return true
   ```

2. `/opt/umbreld/source/modules/is-umbrel-home.ts`
   ```typescript
   // Before
   return manufacturer === 'Umbrel, Inc.' && model === 'Umbrel Home'
   
   // After
   return true
   ```

## 🛡️ Safety First

- ✅ Verifies if files are already patched
- 📝 Provides clear status messages
- ⏮️ Allows cancellation during reboot countdown
- 🔐 Requires sudo privileges

## 📝 Important Notes

- 🔄 System automatically reboots after successful patching
- ⏹️ Press `Ctrl+C` to cancel reboot during countdown
- ↩️ Patch is reversible by restoring original files
- ⚠️ **Important**: Reapply patch after system updates

## 🚨 Troubleshooting

| Issue | Solution |
|-------|----------|
| Permission denied | Run with sudo |
| Files not found | Verify UmbrelOS installation |
| Patch not working | Check file permissions |
| After update | Re-run installation command |

## 🤝 Contributing

Feel free to open issues or submit pull requests!
## 💰 Support and Donations

Support development using cryptocurrencies:

| Currency              | Wallet Address                                                                     |
|----------------------|------------------------------------------------------------------------------------|
| Bitcoin (BTC)        |bc1qt84nyhuzcnkh2qpva93jdqa20hp49edcl94nf6| 
| Ethereum (ETH)       |0xc935e81045CAbE0B8380A284Ed93060dA212fa83| 
| TON                  |UQBlvCgM84ijBQn0-PVP3On0fFVWds5SOHilxbe33EDQgryz|
| Binance Coin         |0xc935e81045CAbE0B8380A284Ed93060dA212fa83| 
| Solana (SOL)         |3vVxkGKasJWCgoamdJiRPy6is4di72xR98CDj2UdS1BE| 
| Ripple (XRP)         |rPJzfBcU6B8SYU5M8h36zuPcLCgRcpKNB4| 
| Dogecoin (DOGE)      |DST5W1c4FFzHVhruVsa2zE6jh5dznLDkmW| 
| Polkadot (DOT)       |1US84xhUghAhrMtw2bcZh9CXN3i7T1VJB2Gdjy9hNjR3K71| 
| Litecoin (LTC)       |ltc1qcg8qesg8j4wvk9m7e74pm7aanl34y7q9rutvwu| 
| Matic                |0xc935e81045CAbE0B8380A284Ed93060dA212fa83| 
| Tron (TRX)           |TQkDWCjchCLhNsGwr4YocUHEeezsB4jVo5| 

---

## 📜 License

MIT License - feel free to use and modify! 
