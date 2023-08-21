package com.okflutter.okflutter;

import io.flutter.app.FlutterApplication;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;

public class UApp extends FlutterApplication {

    @Override
    public void onCreate() {
        super.onCreate();
        FlutterEngine flutterEngine = new FlutterEngine(this);
// 设置要缓存的页面
        flutterEngine.getNavigationChannel().setInitialRoute("index");//这里login和Dart保持一致
// 开始执行Dart代码以预热FlutterEngine
        flutterEngine.getDartExecutor().executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault());
// 缓存FlutterActivity要使用的FlutterEngine
        FlutterEngineCache.getInstance().put("engine_id", flutterEngine);
    }
}
