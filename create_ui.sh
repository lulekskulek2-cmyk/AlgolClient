#!/data/data/com.termux/files/usr/bin/bash

echo "🌟 ALGOL CLIENT - Creating UI & Theme 🌟"
echo "========================================"
echo ""

GREEN='\033[0;32m'
PURPLE='\033[0;35m'
NC='\033[0m'

# ========== ALGOL THEME ==========

echo -e "${PURPLE}Creating Algol Theme (Dark Purple + Stars)...${NC}"

cat > app/src/main/java/com/algol/client/ui/theme/AlgolTheme.kt << 'EOF'
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
EOF

echo -e "${GREEN}✓ Algol Theme created${NC}"

# ========== MAIN ACTIVITY ==========

echo -e "${PURPLE}Creating MainActivity...${NC}"

cat > app/src/main/java/com/algol/client/MainActivity.kt << 'EOF'
package com.algol.client

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.ui.Modifier
import com.algol.client.ui.screens.MainScreen
import com.algol.client.ui.theme.AlgolTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            AlgolTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    MainScreen()
                }
            }
        }
    }
}
EOF

echo -e "${GREEN}✓ MainActivity created${NC}"

# ========== MAIN SCREEN ==========

echo -e "${PURPLE}Creating Main Screen UI...${NC}"

cat > app/src/main/java/com/algol/client/ui/screens/MainScreen.kt << 'EOF'
package com.algol.client.ui.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.algol.client.modules.Module
import com.algol.client.modules.ModuleManager

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun MainScreen() {
    var selectedCategory by remember { mutableStateOf(Module.Category.COMBAT) }
    
    Scaffold(
        topBar = {
            TopAppBar(
                title = {
                    Text(
                        "✦ ALGOL CLIENT ✦",
                        fontWeight = FontWeight.Bold,
                        fontSize = 24.sp
                    )
                },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor = MaterialTheme.colorScheme.primary,
                    titleContentColor = MaterialTheme.colorScheme.onPrimary
                )
            )
        }
    ) { padding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
        ) {
            // Category tabs
            CategoryTabs(
                selectedCategory = selectedCategory,
                onCategorySelected = { selectedCategory = it }
            )
            
            // Module list
            ModuleList(
                category = selectedCategory,
                modifier = Modifier.fillMaxSize()
            )
        }
    }
}

@Composable
fun CategoryTabs(
    selectedCategory: Module.Category,
    onCategorySelected: (Module.Category) -> Unit
) {
    ScrollableTabRow(
        selectedTabIndex = Module.Category.entries.indexOf(selectedCategory),
        containerColor = MaterialTheme.colorScheme.surface,
        contentColor = MaterialTheme.colorScheme.primary
    ) {
        Module.Category.entries.forEach { category ->
            Tab(
                selected = selectedCategory == category,
                onClick = { onCategorySelected(category) },
                text = { 
                    Text(
                        category.name,
                        fontWeight = if (selectedCategory == category) 
                            FontWeight.Bold else FontWeight.Normal
                    ) 
                }
            )
        }
    }
}

@Composable
fun ModuleList(
    category: Module.Category,
    modifier: Modifier = Modifier
) {
    val modules = remember(category) {
        ModuleManager.getModulesByCategory(category)
    }
    
    LazyColumn(
        modifier = modifier.padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(12.dp)
    ) {
        items(modules) { module ->
            ModuleCard(module = module)
        }
    }
}

@Composable
fun ModuleCard(module: Module) {
    var expanded by remember { mutableStateOf(false) }
    var enabled by remember { mutableStateOf(module.enabled) }
    
    Card(
        modifier = Modifier.fillMaxWidth(),
        shape = RoundedCornerShape(16.dp),
        colors = CardDefaults.cardColors(
            containerColor = MaterialTheme.colorScheme.surface
        ),
        elevation = CardDefaults.cardElevation(defaultElevation = 4.dp)
    ) {
        Column(
            modifier = Modifier.padding(16.dp)
        ) {
            // Module header
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Column(modifier = Modifier.weight(1f)) {
                    Text(
                        text = module.name,
                        fontSize = 20.sp,
                        fontWeight = FontWeight.Bold,
                        color = if (enabled) 
                            MaterialTheme.colorScheme.primary 
                        else 
                            MaterialTheme.colorScheme.onSurface
                    )
                    Text(
                        text = module.description,
                        fontSize = 14.sp,
                        color = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }
                
                Row(
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.spacedBy(8.dp)
                ) {
                    // Toggle switch
                    Switch(
                        checked = enabled,
                        onCheckedChange = {
                            enabled = it
                            module.toggle()
                        },
                        colors = SwitchDefaults.colors(
                            checkedThumbColor = MaterialTheme.colorScheme.primary,
                            checkedTrackColor = MaterialTheme.colorScheme.primaryContainer
                        )
                    )
                    
                    // Expand button
                    if (module.settings.isNotEmpty()) {
                        IconButton(onClick = { expanded = !expanded }) {
                            Icon(
                                imageVector = if (expanded) 
                                    Icons.Default.KeyboardArrowUp 
                                else 
                                    Icons.Default.KeyboardArrowDown,
                                contentDescription = "Expand"
                            )
                        }
                    }
                }
            }
            
            // Settings (when expanded)
            if (expanded && module.settings.isNotEmpty()) {
                Spacer(modifier = Modifier.height(16.dp))
                Divider(color = MaterialTheme.colorScheme.outline)
                Spacer(modifier = Modifier.height(16.dp))
                
                module.settings.forEach { setting ->
                    SettingItem(setting = setting)
                    Spacer(modifier = Modifier.height(12.dp))
                }
            }
        }
    }
}

@Composable
fun SettingItem(setting: Module.Setting<*>) {
    Column(modifier = Modifier.fillMaxWidth()) {
        Text(
            text = setting.name,
            fontWeight = FontWeight.Medium,
            color = MaterialTheme.colorScheme.onSurface
        )
        Text(
            text = setting.description,
            fontSize = 12.sp,
            color = MaterialTheme.colorScheme.onSurfaceVariant
        )
        Spacer(modifier = Modifier.height(8.dp))
        
        when (setting) {
            is Module.IntSetting -> {
                var value by remember { mutableStateOf(setting.value.toFloat()) }
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Slider(
                        value = value,
                        onValueChange = { 
                            value = it
                            setting.value = it.toInt()
                        },
                        valueRange = setting.min.toFloat()..setting.max.toFloat(),
                        modifier = Modifier.weight(1f)
                    )
                    Spacer(modifier = Modifier.width(8.dp))
                    Text(
                        text = setting.value.toString(),
                        fontWeight = FontWeight.Bold,
                        color = MaterialTheme.colorScheme.primary
                    )
                }
            }
            
            is Module.FloatSetting -> {
                var value by remember { mutableStateOf(setting.value) }
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Slider(
                        value = value,
                        onValueChange = { 
                            value = it
                            setting.value = it
                        },
                        valueRange = setting.min..setting.max,
                        modifier = Modifier.weight(1f)
                    )
                    Spacer(modifier = Modifier.width(8.dp))
                    Text(
                        text = String.format("%.1f", setting.value),
                        fontWeight = FontWeight.Bold,
                        color = MaterialTheme.colorScheme.primary
                    )
                }
            }
            
            is Module.BooleanSetting -> {
                var checked by remember { mutableStateOf(setting.value) }
                Switch(
                    checked = checked,
                    onCheckedChange = {
                        checked = it
                        setting.value = it
                    }
                )
            }
            
            is Module.ModeSetting -> {
                var expanded by remember { mutableStateOf(false) }
                var selected by remember { mutableStateOf(setting.value) }
                
                ExposedDropdownMenuBox(
                    expanded = expanded,
                    onExpandedChange = { expanded = it }
                ) {
                    OutlinedTextField(
                        value = selected,
                        onValueChange = {},
                        readOnly = true,
                        trailingIcon = {
                            ExposedDropdownMenuDefaults.TrailingIcon(expanded = expanded)
                        },
                        modifier = Modifier
                            .menuAnchor()
                            .fillMaxWidth()
                    )
                    
                    ExposedDropdownMenu(
                        expanded = expanded,
                        onDismissRequest = { expanded = false }
                    ) {
                        setting.modes.forEach { mode ->
                            DropdownMenuItem(
                                text = { Text(mode) },
                                onClick = {
                                    selected = mode
                                    setting.value = mode
                                    expanded = false
                                }
                            )
                        }
                    }
                }
            }
        }
    }
}
EOF

echo -e "${GREEN}✓ Main Screen UI created${NC}"

# ========== RESOURCES ==========

echo -e "${PURPLE}Creating resources...${NC}"

# themes.xml
cat > app/src/main/res/values/themes.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <style name="Theme.AlgolClient" parent="android:Theme.Material.Light.NoActionBar">
        <item name="android:statusBarColor">@android:color/transparent</item>
    </style>
</resources>
EOF

# strings.xml
cat > app/src/main/res/values/strings.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">Algol Client</string>
</resources>
EOF

echo -e "${GREEN}✓ Resources created${NC}"

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}✓ ALGOL CLIENT UI - Complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "Next: Run bash finalize.sh to complete the setup"
echo ""

