package com.smaato.demoapp.activities;

import android.content.Context;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.Toast;

import com.smaato.demoapp.R;
import com.smaato.demoapp.utils.Constants;
import com.smaato.soma.AdDownloaderInterface;
import com.smaato.soma.AdListenerInterface;
import com.smaato.soma.AlertBannerStateListener;
import com.smaato.soma.ErrorCode;
import com.smaato.soma.FullScreenBanner;
import com.smaato.soma.ReceivedBannerInterface;
import com.smaato.soma.exception.AdReceiveFailed;

public class AppFullScreenBannerSample extends ActionBarActivity implements
		OnClickListener, AdListenerInterface, AlertBannerStateListener {

	FullScreenBanner mFullScreenBanner;
	Button loadBanner;
	private static final String TAG = "Alert Banner Sample";

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_full_screen_banner_sample);
		loadBanner = (Button) findViewById(R.id.load_ad );
		loadBanner.setOnClickListener(this);
		setTitleColor(Color.WHITE);
		getSupportActionBar().setBackgroundDrawable(
				new ColorDrawable(Color.parseColor("#3498db")));
		mFullScreenBanner = new FullScreenBanner(getApplicationContext());
		mFullScreenBanner.addAdListener(this);
		mFullScreenBanner.setAlertBannerStateListener(this);
		SharedPreferences prefs = this.getSharedPreferences(Constants.COM_SMAATO_DEMOAPP,
				Context.MODE_PRIVATE);
		mFullScreenBanner.setPublisherId(Integer.parseInt(prefs.getString(Constants.COM_SMAATO_DEMOAPP+Constants.PUBLISHER_ID, "0")));
		mFullScreenBanner.setAdSpaceId(Integer.parseInt(prefs.getString(Constants.COM_SMAATO_DEMOAPP+Constants.AD_SPACE_ID, "0")));

	}

	@Override
	protected void onPause() {
		super.onPause();
		mFullScreenBanner.dismiss();
	}

	@Override
	public void onClick(View v) {
		if (v == loadBanner) {
			mFullScreenBanner.asyncLoadNewBanner();
		}
	}

	@Override
	public void onWillLeaveActivity() {
		Log.i(TAG, "onWillLeaveActivity() has been called ...");
	}

	@Override
	public void onWillCancelAlert() {
		Log.i(TAG, "onWillCancelAlert() has been called ...");
	}

	@Override
	public void onWillShowBanner() {
		Log.i(TAG, "onWillShowBanner() has been called ...");
	}

	@Override
	public void onReceiveAd(AdDownloaderInterface sender,
			ReceivedBannerInterface receivedBanner) throws AdReceiveFailed {
		if (receivedBanner.getErrorCode() != ErrorCode.NO_ERROR && this != null) {
			Toast.makeText(this, receivedBanner.getErrorMessage(),
					Toast.LENGTH_SHORT).show();
		}
	}
}
