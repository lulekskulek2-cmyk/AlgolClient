package com.algol.client.modules

abstract class Module(
    val name: String,
    val description: String,
    val category: Category
) {
    var enabled = false
        private set
    
    val settings = mutableListOf<Setting<*>>()
    
    enum class Category {
        COMBAT, MOVEMENT, RENDER, PLAYER, WORLD, MISC
    }
    
    open fun onEnable() {}
    open fun onDisable() {}
    open fun onUpdate() {}
    
    fun toggle() {
        enabled = !enabled
        if (enabled) onEnable() else onDisable()
    }
    
    fun enable() {
        if (!enabled) {
            enabled = true
            onEnable()
        }
    }
    
    fun disable() {
        if (enabled) {
            enabled = false
            onDisable()
        }
    }
    
    // Setting system
    abstract class Setting<T>(
        val name: String,
        val description: String,
        var value: T
    )
    
    class IntSetting(
        name: String,
        description: String,
        value: Int,
        val min: Int,
        val max: Int
    ) : Setting<Int>(name, description, value)
    
    class FloatSetting(
        name: String,
        description: String,
        value: Float,
        val min: Float,
        val max: Float
    ) : Setting<Float>(name, description, value)
    
    class BooleanSetting(
        name: String,
        description: String,
        value: Boolean
    ) : Setting<Boolean>(name, description, value)
    
    class ModeSetting(
        name: String,
        description: String,
        value: String,
        val modes: List<String>
    ) : Setting<String>(name, description, value)
    
    protected fun intSetting(
        name: String,
        description: String,
        default: Int,
        min: Int,
        max: Int
    ): IntSetting {
        val setting = IntSetting(name, description, default, min, max)
        settings.add(setting)
        return setting
    }
    
    protected fun floatSetting(
        name: String,
        description: String,
        default: Float,
        min: Float,
        max: Float
    ): FloatSetting {
        val setting = FloatSetting(name, description, default, min, max)
        settings.add(setting)
        return setting
    }
    
    protected fun booleanSetting(
        name: String,
        description: String,
        default: Boolean
    ): BooleanSetting {
        val setting = BooleanSetting(name, description, default)
        settings.add(setting)
        return setting
    }
    
    protected fun modeSetting(
        name: String,
        description: String,
        default: String,
        modes: List<String>
    ): ModeSetting {
        val setting = ModeSetting(name, description, default, modes)
        settings.add(setting)
        return setting
    }
}
