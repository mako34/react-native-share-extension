package com.riplamieu.share;

//package com.riplamieu.BuildConfig;

import android.app.Application;
import android.util.Log;

import com.alinz.parkerdan.shareextension.SharePackage;

import com.facebook.react.shell.MainReactPackage;
import com.facebook.react.ReactNativeHost;
import com.facebook.react.ReactApplication;
import com.facebook.react.ReactPackage;
import com.riplamieu.BuildConfig;

import java.util.Arrays;
import java.util.List;

/**
 * Created by manuel on 20/2/18.
 */

public class ShareApplication extends Application implements ReactApplication {
    private final ReactNativeHost mReactNativeHost = new ReactNativeHost(this) {

        @Override
        public boolean getUseDeveloperSupport() {
            return BuildConfig.DEBUG;
        }

        @Override
        protected List<ReactPackage> getPackages() {
            Log.d("mk","ShareApplication getPackages");
            return Arrays.<ReactPackage>asList(

                    new MainReactPackage(),
                    new SharePackage()
            );
        }
    };

    @Override
    public ReactNativeHost getReactNativeHost() {
        return mReactNativeHost;
    }
}
