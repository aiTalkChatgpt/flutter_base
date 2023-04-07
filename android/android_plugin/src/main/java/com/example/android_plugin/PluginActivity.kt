package com.example.android_plugin

import androidx.annotation.NonNull
import com.example.android_plugin.plugin.InstallPlugin
import com.example.android_plugin.util.DeviceIdUtil
import com.example.android_plugin.util.MultiLogUtil
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


open class PluginActivity: FlutterActivity() {

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        registerLogChannel(flutterEngine)
        registerDeviceChannel(flutterEngine)
        flutterEngine.plugins.add(InstallPlugin())
        InstallPlugin.flutterActivity = this
    }

    private fun registerLogChannel(flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "log_channel")
                .setMethodCallHandler { call, result ->
                    if (call.method == "show_log") {
                        val tag = call.argument<String>("tag")
                        val content = call.argument<String>("content")
                        MultiLogUtil.iLog(tag, content)
                    }
                    if (call.method == "net_log") {
                        val tag = call.argument<String>("tag")
                        val url = call.argument<String>("url")
                        val params = call.argument<String>("params")
                        val response = call.argument<String>("response")
                        MultiLogUtil.iLogNet(url, params, response, tag)
                    }
                }
    }

    private fun registerDeviceChannel(flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "device_channel")
                .setMethodCallHandler { call, result ->
                    when (call.method) {
                        "get_hardware_id" -> {
                            result.success( DeviceIdUtil.getHardwareId(this.applicationContext))
                        }
                        "get_android_id" -> {
                            result.success( DeviceIdUtil.getAndroidId(this.applicationContext))
                        }
                        else -> {
                            result.success("请发送指令")
                        }
                    }
                }
    }
}
