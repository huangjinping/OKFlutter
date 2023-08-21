package com.okflutter.okflutter;

import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.net.Uri;
import android.net.http.SslError;
import android.os.Build;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.ViewGroup;
import android.webkit.SslErrorHandler;
import android.webkit.WebChromeClient;
import android.webkit.WebResourceError;
import android.webkit.WebResourceRequest;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.LinearLayout;
import android.widget.ProgressBar;

import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.fragment.app.FragmentActivity;

public class WebViewActivity extends FragmentActivity {
    final String tag = "WebV1iewActi1vity";
    WebView webview;

    ProgressBar progressBar;
    String url = "";
    LinearLayout layoutWebView;


    public static void start(Context context, String url) {
        Intent intent = new Intent(context, WebViewActivity.class);
        intent.putExtra("url", url);
        context.startActivity(intent);
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_webview);
//        webview = findViewById(R.id.webview);
        layoutWebView = findViewById(R.id.layoutWebView);
        webview = new WebView(this);
        layoutWebView.addView(webview, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
        progressBar = findViewById(R.id.progressBar);
        WebSettings settings = webview.getSettings();
        settings.setDomStorageEnabled(true);//是否支持 Local Storage
        settings.setJavaScriptEnabled(true);//支持JavaScript
        settings.setUseWideViewPort(true);//使Webview具有普通的视口(例如普通的桌面浏览器)
        settings.setLoadWithOverviewMode(true);//加载完全缩小的WebView
        settings.setSupportZoom(true);// 设置可以支持缩放
        settings.setBuiltInZoomControls(true);// 设置启用缩放功能
        settings.setDisplayZoomControls(true);//显示缩放控制按钮
        settings.setJavaScriptCanOpenWindowsAutomatically(true);
        settings.setSupportMultipleWindows(true);
        webview.setWebViewClient(new MyWebViewClient());
        webview.setWebChromeClient(new MyWebChromeClient());
        Intent intent = getIntent();
        url = intent.getStringExtra("url");
        webview.loadUrl(url);

    }

    private class MyWebViewClient extends WebViewClient {

//        在api 24（7.0）以下的版本的时候，只会回调shouldOverrideUrlLoading(WebView view, String url)方法
//        在api 24及以上版本的时候，只会回调shouldOverrideUrlLoading（WebView view, WebResourceRequest request)方法
//        注：方法中return true 进行url拦截自己处理，return false由webview系统自己处理。

        @Override
        public boolean shouldOverrideUrlLoading(WebView view, String url) {
//
//            try {
//                if (url.startsWith("http://") || url.startsWith("https://")) {
//                    view.loadUrl(url);
//                    return false;
//                } else {
//                    Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(view.getUrl()));
//                    startActivity(intent);
//                    return true;
//                }
//            } catch (Exception e) {
//                e.printStackTrace();
//            }

            return super.shouldOverrideUrlLoading(view, url);
        }


        @RequiresApi(api = Build.VERSION_CODES.M)
        @Override
        public void onReceivedError(WebView view, WebResourceRequest request, WebResourceError error) {
            super.onReceivedError(view, request, error);
            Log.d("onReceivedError", "" + error.getErrorCode() + "======" + error.getDescription());

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                Log.d(tag, error.getErrorCode() + "----onReceivedError" + error.getDescription());
            }
        }


        //        @Override
//        public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
//            //            //这里需要为true，否则网页中出现非http，https协议的方式会打不开，例如，https://www.jianshu.com/p/4860097148c0
//            return super.shouldOverrideUrlLoading(view, request);
//        }

        @Override
        public void onPageStarted(WebView view, String url, Bitmap favicon) {
            super.onPageStarted(view, url, favicon);
            try {
                if (url.contains("static/Mpsuccess.html")) {
                    //跳转页面
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        //        onReceivedSslError  此方法最好不要使用。
        @Override
        public void onReceivedSslError(WebView view, SslErrorHandler handler, SslError error) {
            super.onReceivedSslError(view, handler, error);
            Log.d("onReceivedSslError", "" + error.getPrimaryError());
            view.getUrl();
            handler.proceed();
        }
    }

    private class MyWebChromeClient extends WebChromeClient {


        @Override
        public void onReceivedTitle(WebView view, String title) {
            super.onReceivedTitle(view, title);
            if (TextUtils.isEmpty(title)) {
                //赋值标题赋值操作
            }
        }

        @Override
        public void onProgressChanged(WebView view, int newProgress) {
            super.onProgressChanged(view, newProgress);

            try {
                Log.d(tag, "newProgress  " + newProgress);
                progressBar.setProgress(newProgress);
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
    }
}
