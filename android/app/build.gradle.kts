plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.flutter_word_remeber"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"
    signingConfigs {
        create("release") {
            keyAlias = "china"
            keyPassword = "123456"
            storeFile = file("../kestore")  // 替换成实际路径
            storePassword = "123456"
        }
        create("debug1") {
            keyAlias = "china"
            keyPassword = "123456"
            storeFile = file("../kestore")  // 替换成实际路径
            storePassword = "123456"
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_1_8.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.clark.xlearn"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("release")
//            signingConfig = signingConfigs.release
        }
        debug {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug1")
//            signingConfig = signingConfigs.release
        }
    }
}

flutter {
    source = "../.."
}
