package com.riplamieu.share;

import android.util.Log;

import com.facebook.react.ReactActivity;


/**
 * Created by manuel on 20/2/18.
 */

public class ShareActivity extends ReactActivity{
    @Override
    protected String getMainComponentName() {
        // this is the name AppRegistry will use to launch the Share View
        Log.d("mk", "ShareActivity getMainComponentName ");
        return "riplamieu";
    }

}
