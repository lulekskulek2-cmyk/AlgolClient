package com.algol.client.network

import android.util.Log
import java.util.concurrent.ConcurrentHashMap
import kotlin.math.sqrt

data class Entity(
    val id: Long,
    var x: Float,
    var y: Float,
    var z: Float,
    var yaw: Float,
    var pitch: Float,
    var health: Float = 20f
)

object EntityTracker {
    private const val TAG = "AlgolEntityTracker"
    private val entities = ConcurrentHashMap<Long, Entity>()
    var localPlayer: Entity? = null
        private set
    
    fun addEntity(entity: Entity) {
        entities[entity.id] = entity
        Log.d(TAG, "✦ Tracked entity: ${entity.id}")
    }
    
    fun removeEntity(entityId: Long) {
        entities.remove(entityId)
    }
    
    fun setLocalPlayer(entity: Entity) {
        localPlayer = entity
        Log.i(TAG, "✦ Local player set ✦")
    }
    
    fun getEntity(entityId: Long): Entity? = entities[entityId]
    
    fun getAllEntities(): List<Entity> = entities.values.toList()
    
    fun getEntitiesInRange(range: Float): List<Entity> {
        val player = localPlayer ?: return emptyList()
        return entities.values.filter { entity ->
            if (entity.id == player.id) return@filter false
            val dx = entity.x - player.x
            val dy = entity.y - player.y
            val dz = entity.z - player.z
            val distance = sqrt(dx * dx + dy * dy + dz * dz)
            distance <= range
        }
    }
    
    fun getNearestEntity(maxRange: Float = Float.MAX_VALUE): Entity? {
        val player = localPlayer ?: return null
        return entities.values
            .filter { it.id != player.id }
            .minByOrNull { entity ->
                val dx = entity.x - player.x
                val dy = entity.y - player.y
                val dz = entity.z - player.z
                sqrt(dx * dx + dy * dy + dz * dz)
            }
    }
    
    fun clear() {
        entities.clear()
        localPlayer = null
    }
}
