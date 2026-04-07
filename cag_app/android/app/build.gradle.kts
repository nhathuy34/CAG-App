import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

// Đọc file .env
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
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    // --- ĐÂY LÀ CHỖ SỬA: Cú pháp compilerOptions chuẩn cho Kotlin 2.x ---
    tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinJvmCompile>().configureEach {
        compilerOptions {
            jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_11)
        }
    }

    defaultConfig {
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