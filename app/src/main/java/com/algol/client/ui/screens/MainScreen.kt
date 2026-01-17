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
