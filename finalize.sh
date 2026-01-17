#!/data/data/com.termux/files/usr/bin/bash

echo "🌟 ALGOL CLIENT - Final Setup 🌟"
echo "================================="
echo ""

GREEN='\033[0;32m'
PURPLE='\033[0;35m'
BLUE='\033[0;36m'
NC='\033[0m'

# ========== GRADLE WRAPPER ==========

echo -e "${PURPLE}Setting up Gradle Wrapper...${NC}"

cat > gradlew << 'EOF'
#!/usr/bin/env sh
# Gradle startup script for POSIX

GRADLE_VERSION=8.2

if [ ! -d "$HOME/.gradle/wrapper/dists/gradle-$GRADLE_VERSION-bin" ]; then
    echo "Downloading Gradle $GRADLE_VERSION..."
    mkdir -p "$HOME/.gradle/wrapper/dists"
fi

exec gradle "$@"
EOF

chmod +x gradlew

echo -e "${GREEN}✓ Gradle wrapper created${NC}"

# ========== PROGUARD ==========

echo -e "${PURPLE}Creating ProGuard rules...${NC}"

cat > app/proguard-rules.pro << 'EOF'
# Algol Client ProGuard Rules

# Keep module classes
-keep class com.algol.client.modules.** { *; }

# Keep Compose
-keep class androidx.compose.** { *; }
-dontwarn androidx.compose.**

# Keep Kotlin
-keep class kotlin.** { *; }
-dontwarn kotlin.**

# Keep coroutines
-keepnames class kotlinx.coroutines.internal.MainDispatcherFactory {}
-keepnames class kotlinx.coroutines.CoroutineExceptionHandler {}
EOF

echo -e "${GREEN}✓ ProGuard rules created${NC}"

# ========== GITIGNORE ==========

echo -e "${PURPLE}Creating .gitignore...${NC}"

cat > .gitignore << 'EOF'
# Built application files
*.apk
*.aar
*.ap_
*.aab

# Files for the ART/Dalvik VM
*.dex

# Java class files
*.class

# Generated files
bin/
gen/
out/
release/

# Gradle files
.gradle/
build/
gradle-app.setting
!gradle-wrapper.jar

# Local configuration file
local.properties

# IntelliJ
*.iml
.idea/
misc.xml
deploymentTargetDropDown.xml
render.experimental.xml

# Android Studio
captures/
.externalNativeBuild
.cxx
*.apk
output.json

# Keystore files
*.jks
*.keystore

# Google Services
google-services.json

# OS-specific files
.DS_Store
Thumbs.db
EOF

echo -e "${GREEN}✓ .gitignore created${NC}"

# ========== README ==========

echo -e "${PURPLE}Creating README.md...${NC}"

cat > README.md << 'EOF'
# ✦ ALGOL CLIENT ✦

![Version](https://img.shields.io/badge/version-1.0.0-purple)
![Platform](https://img.shields.io/badge/platform-Android-green)
![License](https://img.shields.io/badge/license-GPL--3.0-blue)

## 🌟 About

Algol Client is a Minecraft Bedrock Edition client built from scratch, featuring a dark purple space theme and advanced PvP modules.

Named after the "Demon Star" (Beta Persei), Algol brings powerful combat features in a sleek, modern interface.

## ✨ Features

### Combat Modules

#### KillAura
- **Range**: 3.0 - 6.0 blocks
- **CPS**: 1 - 20 clicks per second
- **Delay**: 0 - 500ms custom delay
- **Target Modes**: Single, Multi, Switch
- **Rotation**: None, Silent, Snap, Smooth
- **Attack Patterns**: Sequential, Random, Priority
- **RayTrace**: Attack only visible targets
- **AutoBlock**: Automatic blocking
- **Swing Arm**: Visual arm swing

#### Scaffold
- **Modes**: Normal, Godbridge, Telly, Eagle
- **Tower**: Automatic tower up
- **Sprint**: Keep sprint enabled
- **SafeWalk**: Prevent edge falls
- **Rotation**: Smart rotation
- **Delay**: 0 - 200ms placement delay
- **Expand**: Place 0-5 blocks ahead

## 🎨 Design

- **Theme**: Deep Purple & Space Black
- **Style**: Modern Material Design 3
- **UI**: Glassmorphism with star particles
- **Colors**: 
  - Primary: Deep Purple (#6200EA)
  - Accent: Star Purple (#BB86FC)
  - Background: Space Black (#121212)

## 🚀 Installation

### From APK
1. Download latest APK from Releases
2. Enable "Install from Unknown Sources"
3. Install and launch

### Build from Source
```bash
# Clone repository
git clone https://github.com/lulekskulek2-cmyk/AlgolClient.git
cd AlgolClient

# Build (requires Android SDK)
./gradlew assembleRelease

# APK will be in: app/build/outputs/apk/release/
cat > finalize.sh << 'ENDOFSCRIPT'
#!/data/data/com.termux/files/usr/bin/bash

echo "🌟 ALGOL CLIENT - Final Setup 🌟"
echo "================================="
echo ""

GREEN='\033[0;32m'
PURPLE='\033[0;35m'
BLUE='\033[0;36m'
NC='\033[0m'

# ========== GRADLE WRAPPER ==========

echo -e "${PURPLE}Setting up Gradle Wrapper...${NC}"

cat > gradlew << 'EOF'
#!/usr/bin/env sh
# Gradle startup script for POSIX

GRADLE_VERSION=8.2

if [ ! -d "$HOME/.gradle/wrapper/dists/gradle-$GRADLE_VERSION-bin" ]; then
    echo "Downloading Gradle $GRADLE_VERSION..."
    mkdir -p "$HOME/.gradle/wrapper/dists"
fi

exec gradle "$@"
EOF

chmod +x gradlew

echo -e "${GREEN}✓ Gradle wrapper created${NC}"

# ========== PROGUARD ==========

echo -e "${PURPLE}Creating ProGuard rules...${NC}"

cat > app/proguard-rules.pro << 'EOF'
# Algol Client ProGuard Rules

# Keep module classes
-keep class com.algol.client.modules.** { *; }

# Keep Compose
-keep class androidx.compose.** { *; }
-dontwarn androidx.compose.**

# Keep Kotlin
-keep class kotlin.** { *; }
-dontwarn kotlin.**

# Keep coroutines
-keepnames class kotlinx.coroutines.internal.MainDispatcherFactory {}
-keepnames class kotlinx.coroutines.CoroutineExceptionHandler {}
EOF

echo -e "${GREEN}✓ ProGuard rules created${NC}"

# ========== GITIGNORE ==========

echo -e "${PURPLE}Creating .gitignore...${NC}"

cat > .gitignore << 'EOF'
# Built application files
*.apk
*.aar
*.ap_
*.aab

# Files for the ART/Dalvik VM
*.dex

# Java class files
*.class

# Generated files
bin/
gen/
out/
release/

# Gradle files
.gradle/
build/
gradle-app.setting
!gradle-wrapper.jar

# Local configuration file
local.properties

# IntelliJ
*.iml
.idea/
misc.xml
deploymentTargetDropDown.xml
render.experimental.xml

# Android Studio
captures/
.externalNativeBuild
.cxx
*.apk
output.json

# Keystore files
*.jks
*.keystore

# Google Services
google-services.json

# OS-specific files
.DS_Store
Thumbs.db
EOF

echo -e "${GREEN}✓ .gitignore created${NC}"

# ========== README ==========

echo -e "${PURPLE}Creating README.md...${NC}"

cat > README.md << 'EOF'
# ✦ ALGOL CLIENT ✦

![Version](https://img.shields.io/badge/version-1.0.0-purple)
![Platform](https://img.shields.io/badge/platform-Android-green)
![License](https://img.shields.io/badge/license-GPL--3.0-blue)

## 🌟 About

Algol Client is a Minecraft Bedrock Edition client built from scratch, featuring a dark purple space theme and advanced PvP modules.

Named after the "Demon Star" (Beta Persei), Algol brings powerful combat features in a sleek, modern interface.

## ✨ Features

### Combat Modules

#### KillAura
- **Range**: 3.0 - 6.0 blocks
- **CPS**: 1 - 20 clicks per second
- **Delay**: 0 - 500ms custom delay
- **Target Modes**: Single, Multi, Switch
- **Rotation**: None, Silent, Snap, Smooth
- **Attack Patterns**: Sequential, Random, Priority
- **RayTrace**: Attack only visible targets
- **AutoBlock**: Automatic blocking
- **Swing Arm**: Visual arm swing

#### Scaffold
- **Modes**: Normal, Godbridge, Telly, Eagle
- **Tower**: Automatic tower up
- **Sprint**: Keep sprint enabled
- **SafeWalk**: Prevent edge falls
- **Rotation**: Smart rotation
- **Delay**: 0 - 200ms placement delay
- **Expand**: Place 0-5 blocks ahead

## 🎨 Design

- **Theme**: Deep Purple & Space Black
- **Style**: Modern Material Design 3
- **UI**: Glassmorphism with star particles
- **Colors**: 
  - Primary: Deep Purple (#6200EA)
  - Accent: Star Purple (#BB86FC)
  - Background: Space Black (#121212)

## 🚀 Installation

### From APK
1. Download latest APK from Releases
2. Enable "Install from Unknown Sources"
3. Install and launch

### Build from Source
```bash
# Clone repository
git clone https://github.com/lulekskulek2-cmyk/AlgolClient.git
cd AlgolClient

# Build (requires Android SDK)
./gradlew assembleRelease

# APK will be in: app/build/outputs/apk/release/
📱 Requirements
Android 9.0 (API 28) or higher
Minecraft Bedrock Edition 1.21+
2GB RAM minimum
200MB storage
⚙️ Usage
Launch Algol Client
Select module category (Combat, Movement, etc.)
Enable desired modules
Configure settings for each module
Join Minecraft server
🛠️ Development
Built with:
Kotlin - Primary language
Jetpack Compose - Modern UI
Material Design 3 - Design system
Coroutines - Async operations
Gradle - Build system
📝 License
This project is licensed under the GNU General Public License v3.0.
See LICENSE for details.
⚠️ Disclaimer
This client is for educational purposes. Using hacked clients may violate server terms of service and result in bans. Use responsibly.
👨‍💻 Author
Created by: lulekskulek2-cmyk
🌟 Credits
Inspired by various Minecraft clients
Built with love and dedication
Special thanks to the open-source community
✦ May the stars guide your battles ✦
EOF
echo -e "{GREEN}✓ README created{NC}"
========== LICENSE ==========
echo -e "{PURPLE}Creating LICENSE...{NC}"
cat > LICENSE << 'EOF'
GNU GENERAL PUBLIC LICENSE
Version 3, 29 June 2007
Copyright (C) 2025 lulekskulek2-cmyk
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see https://www.gnu.org/licenses/.
EOF
echo -e "{GREEN}✓ LICENSE created{NC}"
========== PROJECT SUMMARY ==========
echo ""
echo -e "{BLUE}╔════════════════════════════════════════╗{NC}"
echo -e "{BLUE}║                                        ║{NC}"
echo -e "{BLUE}║   {BLUE}                  ║{NC}"
echo -e "{BLUE}║   {BLUE}            ║{NC}"
echo -e "{BLUE}║                                        ║{NC}"
echo -e "{BLUE}╚════════════════════════════════════════╝{NC}"
echo ""
echo -e "{GREEN}✓ Created:{NC}"
echo "  - Module system with settings"
echo "  - KillAura module (full featured)"
echo "  - Scaffold module (full featured)"
echo "  - Dark purple space theme"
echo "  - Modern Material Design 3 UI"
echo "  - Complete project structure"
echo ""
echo -e "{PURPLE}📦 Project Structure:{NC}"
echo "  AlgolClient/"
echo "  ├── app/"
echo "  │   ├── src/main/"
echo "  │   │   ├── java/com/algol/client/"
echo "  │   │   │   ├── modules/ (KillAura, Scaffold)"
echo "  │   │   │   ├── ui/ (Theme, Screens)"
echo "  │   │   │   └── MainActivity.kt"
echo "  │   │   ├── res/ (Resources)"
echo "  │   │   └── AndroidManifest.xml"
echo "  │   └── build.gradle.kts"
echo "  ├── build.gradle.kts"
echo "  ├── settings.gradle.kts"
echo "  ├── README.md"
echo "  └── LICENSE"
echo ""
echo -e "{BLUE}🚀 Next Steps:{NC}"
echo "  1. Review the code: ls -R app/src/"
echo "  2. Push to GitHub:"
echo "     git add ."
echo "     git commit -m 'Initial Algol Client commit'"
echo "     git push origin main"
echo ""
echo -e "{PURPLE}⚠️  To build APK:{NC}"
echo "  You'll need Android SDK installed"
echo "  Then run: ./gradlew assembleRelease"
echo ""
echo -e "{GREEN}✦ Algol Client is ready! ✦{NC}"
echo ""
