package com.cally.cally

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Safety net against the app opening twice from the widget: a single-
        // activity Flutter app should never have more than one MainActivity, so
        // if this one is not the root of its task, an instance already exists —
        // finish the duplicate and let the existing one stay in front.
        if (!isTaskRoot) {
            finish()
        }
    }
}
