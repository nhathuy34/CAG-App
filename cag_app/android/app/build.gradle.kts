import java.util.Properties // <--- QUAN TRỌNG: Thêm dòng này để fix lỗi "util"

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Cách đọc file .env chuẩn chỉnh cho Kotlin Script
val env = Properties()
val envFile = rootProject.file("../.env") 

if (envFile.exists()) {
    envFile.inputStream().use { stream ->
        env.load(stream)
    }
}

android {
    namespace = "com.example.cag_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    // THAY THẾ khối kotlinOptions cũ bằng khối này:
    kotlin {
        compilerOptions {
            jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
        }
    }

    defaultConfig {
        // Lấy key từ file .env, nếu không thấy thì để trống
        val apiKey = env.getProperty("GOOGLE_MAPS_API_KEY") ?: ""
        manifestPlaceholders["mapsApiKey"] = apiKey

        applicationId = "com.example.cag_app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}