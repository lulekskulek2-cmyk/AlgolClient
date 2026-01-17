package com.algol.client.modules

import com.algol.client.modules.combat.KillAura
import com.algol.client.modules.combat.Scaffold

object ModuleManager {
    private val modules = mutableListOf<Module>()
    
    init {
        // Combat modules
        register(KillAura())
        register(Scaffold())
    }
    
    private fun register(module: Module) {
        modules.add(module)
    }
    
    fun getModules(): List<Module> = modules
    
    fun getModule(name: String): Module? = 
        modules.find { it.name.equals(name, ignoreCase = true) }
    
    fun getModulesByCategory(category: Module.Category): List<Module> = 
        modules.filter { it.category == category }
    
    fun getEnabledModules(): List<Module> = 
        modules.filter { it.enabled }
    
    fun onUpdate() {
        modules.filter { it.enabled }.forEach { it.onUpdate() }
    }
}
