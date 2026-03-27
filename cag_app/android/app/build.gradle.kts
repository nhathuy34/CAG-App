import java.util.Properties
plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

// Cách đọc file .env chuẩn chỉnh cho Kotlin Script
val env = Properties()
val envFile = rootProject.file("../assets/.env") 

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
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlin {
        compilerOptions {
            jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_11)
        }
    }

    defaultConfig {
        // Lấy key từ file .env, nếu không thấy thì để trống
        val apiKey = env.getProperty("API_KEY") ?: ""
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