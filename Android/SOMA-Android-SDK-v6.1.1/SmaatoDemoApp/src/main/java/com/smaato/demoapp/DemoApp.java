package com.smaato.demoapp;

import android.app.Application;
import android.content.Context;
import android.os.Build;
import android.os.StrictMode;
import android.webkit.WebView;

import com.squareup.leakcanary.LeakCanary;

import static android.os.Build.VERSION.SDK_INT;
import static android.os.Build.VERSION_CODES.GINGERBREAD;

/**
 * Created by palani on 24/02/17.
 */
public class DemoApp extends Application {

    private boolean isDev = false;

    @Override
    public void onCreate() {
        super.onCreate();
        //  instance = this;

        if(isDev){
            if ( LeakCanary.isInAnalyzerProcess(this)) {
                // This process is dedicated to LeakCanary for heap analysis.
                // You should not init your app in this process.
                return;
            }
            enabledStrictMode();
            LeakCanary.install(this);
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            WebView.setWebContentsDebuggingEnabled(true);
        }

    }

    private void enabledStrictMode() {
        if (SDK_INT >= GINGERBREAD) {
            StrictMode.setThreadPolicy(new StrictMode.ThreadPolicy.Builder() //
                    .detectAll() //
                    .penaltyLog() //
                    .penaltyDeath() //
                    .build());
        }
    }
}
