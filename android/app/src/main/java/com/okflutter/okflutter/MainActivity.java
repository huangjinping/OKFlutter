package com.okflutter.okflutter;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {

    final String channel = "com.okflutter.connection";

    final String changeMethod = "com.okflutter.changeMethod";
    MethodChannel methodChannel;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

//        new Handler().postDelayed(new Runnable() {
//            @Override
//            public void run() {
//                int i = 1 / 0;
//            }
//        }, 5000);

    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
//        GeneratedPluginRegistrant.registerWith(flutterEngine);

        receiveMessageFromMessage(flutterEngine);
    }

    private void receiveMessageFromMessage(FlutterEngine flutterEngine) {
        methodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), channel);
        methodChannel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
                if (changeMethod.equals(call.method)) {

                    WebViewActivity.start(MainActivity.this, "https://www.baidu.com");

                    Toast.makeText(MainActivity.this, "内部：--" + call.arguments.toString(), Toast.LENGTH_SHORT).show();
                }
            }
        });
    }
}
