package com.alinz.parkerdan.shareextension;

import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.Arguments;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;

public class ShareModule extends ReactContextBaseJavaModule {
    public ShareModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "ReactNativeShareExtension";
    }

    @ReactMethod
    public void close() {
        getCurrentActivity().finish();
    }

    @ReactMethod
    public void data(Promise promise) {
        promise.resolve(processIntent());
    }

    public WritableMap processIntent() {
        WritableMap map = Arguments.createMap();

        String value = "";
        String type = "";
        String action = "";

        Activity currentActivity = getCurrentActivity();

        if (currentActivity != null) {
            Intent intent = currentActivity.getIntent();
            action = intent.getAction();
            type = intent.getType();

            if (type == null) {
                type = "";
            }

            if (Intent.ACTION_SEND.equals(action) && "text/plain".equals(type)) {
                value = intent.getStringExtra(Intent.EXTRA_TEXT);
            } else if (Intent.ACTION_SEND.equals(action)) {
                Uri uri = (Uri) intent.getParcelableExtra(Intent.EXTRA_STREAM);
                value = "file://" + RealPathUtil.getRealPathFromURI(currentActivity, uri);
            } else {
                value = "";
            }
        } else {
            value = "";
            type = "";
        }

        String origin = "JS";
        if (type.length() > 0) {
            origin = "android_extension";
        }

        map.putString("type", type);
        map.putString("value", value);
        map.putString("origin", origin);

        return map;
    }
}
