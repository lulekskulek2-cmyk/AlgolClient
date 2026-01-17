#!/data/data/com.termux/files/usr/bin/bash

echo "🌟 ALGOL CLIENT - Automatic Setup Script 🌟"
echo "============================================"
echo ""

# Kolory
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
NC='\033[0m'

echo -e "${PURPLE}Creating project structure...${NC}"

# Tworzenie struktury folderów
mkdir -p app/src/main/java/com/algol/client/{modules/combat,ui/theme,ui/screens,config,network,utils}
mkdir -p app/src/main/res/{values,drawable,layout,mipmap-hdpi,mipmap-mdpi,mipmap-xhdpi,mipmap-xxhdpi,mipmap-xxxhdpi}
mkdir -p gradle/wrapper

echo -e "${GREEN}✓ Folders created${NC}"

# ========== GRADLE FILES ==========

echo -e "${PURPLE}Creating Gradle configuration files...${NC}"

# settings.gradle.kts
cat > settings.gradle.kts << 'EOF'
pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
        maven { url = uri("https://jitpack.io") }
    }
}

rootProject.name = "AlgolClient"
include(":app")
EOF

# build.gradle.kts (root)
cat > build.gradle.kts << 'EOF'
plugins {
    id("com.android.application") version "8.2.0" apply false
    id("org.jetbrains.kotlin.android") version "1.9.20" apply false
}

tasks.register("clean", Delete::class) {
    delete(rootProject.buildDir)
}
EOF

# gradle.properties
cat > gradle.properties << 'EOF'
org.gradle.jvmargs=-Xmx2048m -Dfile.encoding=UTF-8
org.gradle.parallel=true
android.useAndroidX=true
android.enableJetifier=true
kotlin.code.style=official
EOF

echo -e "${GREEN}✓ Gradle files created${NC}"

# ========== APP BUILD.GRADLE.KTS ==========

echo -e "${PURPLE}Creating app build configuration...${NC}"

cat > app/build.gradle.kts << 'EOF'
plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
}

android {
    namespace = "com.algol.client"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.algol.client"
        minSdk = 28
        targetSdk = 34
        versionCode = 1
        versionName = "1.0.0"

        vectorDrawables {
            useSupportLibrary = true
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    buildFeatures {
        compose = true
    }

    composeOptions {
        kotlinCompilerExtensionVersion = "1.5.4"
    }

    packaging {
        resources {
            excludes += "/META-INF/{AL2.0,LGPL2.1}"
        }
    }
}

dependencies {
    // AndroidX Core
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.lifecycle:lifecycle-runtime-ktx:2.7.0")
    implementation("androidx.activity:activity-compose:1.8.2")

    // Compose
    val composeBom = platform("androidx.compose:compose-bom:2024.01.00")
    implementation(composeBom)
    implementation("androidx.compose.ui:ui")
    implementation("androidx.compose.ui:ui-graphics")
    implementation("androidx.compose.ui:ui-tooling-preview")
    implementation("androidx.compose.material3:material3")
    implementation("androidx.compose.material:material-icons-extended")
    
    // Navigation
    implementation("androidx.navigation:navigation-compose:2.7.6")
    
    // Coroutines
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.7.3")
    
    // JSON
    implementation("com.google.code.gson:gson:2.10.1")
}
EOF

echo -e "${GREEN}✓ App build file created${NC}"

# ========== ANDROID MANIFEST ==========

echo -e "${PURPLE}Creating AndroidManifest.xml...${NC}"

mkdir -p app/src/main
cat > app/src/main/AndroidManifest.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="Algol Client"
        android:theme="@style/Theme.AlgolClient"
        android:supportsRtl="true">
        
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:theme="@style/Theme.AlgolClient">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>

</manifest>
EOF

echo -e "${GREEN}✓ AndroidManifest created${NC}"

echo ""
echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}✓ ALGOL CLIENT - Structure Created!${NC}"
echo -e "${GREEN}============================================${NC}"
echo ""
echo "Next: Run bash create_code.sh to add source files"
echo ""

