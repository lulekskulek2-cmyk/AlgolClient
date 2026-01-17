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
