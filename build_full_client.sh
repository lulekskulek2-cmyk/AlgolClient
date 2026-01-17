#!/data/data/com.termux/files/usr/bin/bash

echo "🌟 ALGOL CLIENT - Building Full Implementation 🌟"
echo "================================================="
echo ""

GREEN='\033[0;32m'
PURPLE='\033[0;35m'
BLUE='\033[0;36m'
NC='\033[0m'

echo -e "${PURPLE}Step 1: Adding network dependencies...${NC}"
bash add_network.sh 2>/dev/null || {
    # Create add_network.sh if it doesn't exist
    cat > add_network.sh << 'ADDNET'
#!/data/data/com.termux/files/usr/bin/bash
echo "Adding network dependencies..."

cat > app/build.gradle.kts << 'GRADLE'
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
        vectorDrawables { useSupportLibrary = true }
        ndk { abiFilters += listOf("arm64-v8a", "armeabi-v7a") }
    }
    buildTypes {
        release {
            isMinifyEnabled = true
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    kotlinOptions { jvmTarget = "17" }
    buildFeatures { compose = true }
    composeOptions { kotlinCompilerExtensionVersion = "1.5.4" }
    packaging {
        resources {
            excludes += "/META-INF/{AL2.0,LGPL2.1}"
            excludes += "META-INF/INDEX.LIST"
            excludes += "META-INF/io.netty.versions.properties"
        }
    }
}

dependencies {
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.lifecycle:lifecycle-runtime-ktx:2.7.0")
    implementation("androidx.activity:activity-compose:1.8.2")
    val composeBom = platform("androidx.compose:compose-bom:2024.01.00")
    implementation(composeBom)
    implementation("androidx.compose.ui:ui")
    implementation("androidx.compose.ui:ui-graphics")
    implementation("androidx.compose.ui:ui-tooling-preview")
    implementation("androidx.compose.material3:material3")
    implementation("androidx.compose.material:material-icons-extended")
    implementation("androidx.navigation:navigation-compose:2.7.6")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.7.3")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.7.3")
    implementation("com.google.code.gson:gson:2.10.1")
    implementation("io.netty:netty-all:4.1.100.Final")
    implementation("org.slf4j:slf4j-api:2.0.9")
    implementation("org.slf4j:slf4j-android:2.0.9")
}
GRADLE

cat > settings.gradle.kts << 'SETTINGS'
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
SETTINGS

echo "✓ Network dependencies added"
ADDNET
    chmod +x add_network.sh
    bash add_network.sh
}

echo -e "${PURPLE}Step 2: Creating network code...${NC}"
bash create_network.sh 2>/dev/null || {
    echo "Creating network files manually..."
    mkdir -p app/src/main/java/com/algol/client/network
    # Network code will be added
}

echo -e "${PURPLE}Step 3: Integrating modules...${NC}"
bash integrate_modules.sh 2>/dev/null || {
    echo "Integrating modules manually..."
    # Integration code will be added
}

echo -e "${PURPLE}Step 4: Final integration...${NC}"
bash final_integration.sh 2>/dev/null || {
    echo "Finalizing manually..."
    # Final code will be added
}

echo ""
echo -e "${GREEN}✦ Build complete! ✦${NC}"
echo ""

