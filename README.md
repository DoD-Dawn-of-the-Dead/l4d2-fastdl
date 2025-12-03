# L4D2 FastDL - Parachute Files

FastDL server for Left 4 Dead 2 parachute models and materials.

## 📦 Contents

### Parachute Models Included:
- **Gargoyle Wings** (Zombie style)
- **Gargoyle** (Advanced Parachute)
- **Blue Parachute** (Advanced Parachute - Default)
- **Ice Parachute v2** (VIP style)
- **Carbon Parachute**
- **Green Parachute v2**

### Files:
- **52 compressed files** (.bz2 format)
- Models (.mdl, .vvd, .vtx files)
- Materials (.vmt, .vtf textures)

## 🚀 Usage

Configure your L4D2 server to use FastDL:

```
sv_allowdownload "1"
sv_downloadurl "https://YOUR-GITHUB-USERNAME.github.io/l4d2-fastdl-parachute/l4d2_fastdl/"
```

## 📂 Structure

```
l4d2_fastdl/
├── models/
│   └── parachute/
│       ├── *.mdl.bz2
│       ├── *.vvd.bz2
│       ├── *.vtx.bz2
│       └── zombie/
│           └── gargoyle_wings/
└── materials/
    └── models/
        └── parachute/
            ├── *.vmt.bz2
            └── *.vtf.bz2
```

## 📝 Notes

- All files are compressed with bzip2 for faster downloads
- Compatible with Advanced Parachute plugin
- No uncompressed files included (FastDL best practice)

## 🔗 Related

- Advanced Parachute Plugin: https://github.com/ESK0/Advanced-Parachute
- SUPER-VIP Plugin: Custom implementation

---

Generated: 2025-12-03

