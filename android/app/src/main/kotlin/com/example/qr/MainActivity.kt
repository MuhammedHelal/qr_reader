package com.example.qr

import io.flutter.embedding.android.FlutterActivity
import android.content.Intent
import android.net.Uri
import androidx.core.content.FileProvider
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
class MainActivity: FlutterActivity(){
    private val CHANNEL = "dev.moashraf.qr_reader.fileprovider"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "getFileUri") {
                    val filePath = call.argument<String>("path")
                    val file = File(filePath!!)
                    val uri = FileProvider.getUriForFile(this, "${BuildConfig.APPLICATION_ID}.fileprovider", file)
                    result.success(uri.toString())
                } else {
                    result.notImplemented()
                }
            }
    }
}
