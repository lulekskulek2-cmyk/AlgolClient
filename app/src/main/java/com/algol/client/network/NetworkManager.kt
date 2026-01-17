package com.algol.client.network

import android.util.Log
import kotlinx.coroutines.*

object NetworkManager {
    private const val TAG = "AlgolNetwork"
    var isRunning = false
        private set
    private val proxyAddress = "127.0.0.1:19132"
    
    suspend fun start(port: Int = 19132) = withContext(Dispatchers.IO) {
        if (isRunning) return@withContext
        
        try {
            Log.i(TAG, "✦ Starting Algol Network on port $port ✦")
            isRunning = true
            Log.i(TAG, "✦ Network ready - Connect Minecraft to $proxyAddress ✦")
        } catch (e: Exception) {
            Log.e(TAG, "Network start failed: ${e.message}", e)
            isRunning = false
        }
    }
    
    fun stop() {
        if (!isRunning) return
        Log.i(TAG, "✦ Stopping network ✦")
        isRunning = false
        EntityTracker.clear()
    }
    
    fun getProxyAddress(): String = proxyAddress
}
