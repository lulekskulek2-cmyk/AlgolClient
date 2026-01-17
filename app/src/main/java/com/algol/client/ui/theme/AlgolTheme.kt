package com.algol.client.ui.theme

import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color

// Algol Color Palette - Deep Purple & Space Black
private val AlgolPurple = Color(0xFF6200EA)
private val AlgolLightPurple = Color(0xFF9D4EDD)
private val AlgolStarPurple = Color(0xFFBB86FC)
private val AlgolAccent = Color(0xFFE0AAFF)
private val SpaceBlack = Color(0xFF121212)
private val DeepSpace = Color(0xFF1E1E1E)
private val StarWhite = Color(0xFFE8E8E8)

private val DarkColorScheme = darkColorScheme(
    primary = AlgolPurple,
    onPrimary = StarWhite,
    primaryContainer = AlgolLightPurple,
    onPrimaryContainer = StarWhite,
    
    secondary = AlgolStarPurple,
    onSecondary = SpaceBlack,
    secondaryContainer = AlgolAccent,
    onSecondaryContainer = SpaceBlack,
    
    tertiary = AlgolAccent,
    onTertiary = SpaceBlack,
    
    background = SpaceBlack,
    onBackground = StarWhite,
    
    surface = DeepSpace,
    onSurface = StarWhite,
    surfaceVariant = Color(0xFF2A2A2A),
    onSurfaceVariant = Color(0xFFCCCCCC),
    
    error = Color(0xFFCF6679),
    onError = Color(0xFF000000),
    
    outline = AlgolLightPurple,
    outlineVariant = AlgolPurple
)

@Composable
fun AlgolTheme(
    darkTheme: Boolean = isSystemInDarkTheme(),
    content: @Composable () -> Unit
) {
    val colorScheme = DarkColorScheme
    
    MaterialTheme(
        colorScheme = colorScheme,
        typography = Typography(),
        content = content
    )
}
