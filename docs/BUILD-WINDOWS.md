# Running Cally on Windows

Cally supports Windows desktop, but the `.exe` must be **compiled on Windows**
(Flutter can't cross-build it from Linux). Three ways to get it to a friend:

## 1. Easiest for a non-developer: download the CI build
A GitHub Actions workflow (`.github/workflows/windows-build.yml`) builds the
Windows app on every push to `main` (and on demand via the Actions tab).

Your friend:
1. Open the repo on GitHub → **Actions** → the latest **Windows build** run.
2. Download the **`Cally-windows`** artifact (a zip) from that run.
3. Unzip it and run **`cally.exe`**. Keep the whole unzipped folder together —
   the `.exe` needs the `data/` folder and the `.dll`s next to it.

(First launch may prompt SmartScreen because the build isn't code-signed →
"More info" → "Run anyway". Signing is a later step.)

## 2. You build it on a Windows PC and send the folder
On a Windows machine with **Flutter** + **Visual Studio** (the *Desktop
development with C++* workload):
```powershell
flutter config --enable-windows-desktop
flutter pub get
flutter build windows --release
```
Zip `build\windows\x64\runner\Release\` and send it. Your friend unzips and runs
`cally.exe` (whole folder together, as above).

## 3. Your friend builds from source
Same prerequisites (Flutter + Visual Studio C++). Clone the repo, then:
```powershell
flutter run -d windows        # debug
# or: flutter build windows --release
```

## Notes
- On Windows the UI, local store (SQLite), notifications, timezone and sharing
  work; home-screen widgets and in-app purchase are mobile-only and no-op here.
- No installer yet — it's a portable folder. An MSIX installer can be added later
  (`msix` package) if you want a one-click install.
