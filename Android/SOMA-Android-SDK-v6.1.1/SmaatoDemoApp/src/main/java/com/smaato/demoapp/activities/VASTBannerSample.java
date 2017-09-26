package com.smaato.demoapp.activities;

import android.Manifest;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Build;
import android.os.Bundle;
import android.support.v4.app.ActivityCompat;
import android.support.v7.app.ActionBarActivity;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.smaato.demoapp.R;
import com.smaato.demoapp.utils.Constants;
import com.smaato.soma.video.VASTAdListener;
import com.smaato.soma.video.Video;

public class VASTBannerSample extends ActionBarActivity implements
 OnClickListener,VASTAdListener, ActivityCompat.OnRequestPermissionsResultCallback {
	Button loadBanner, showBanner;
	TextView messageBoard;
	Video videoAd;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_vastbanner_sample);
		messageBoard = (TextView ) findViewById( R.id.textView1 ) ;
		videoAd = new Video(VASTBannerSample.this);
		videoAd.setVastAdListener(VASTBannerSample.this);
		loadBanner = (Button) findViewById(R.id.load_ad );
		loadBanner.setOnClickListener(VASTBannerSample.this);
		showBanner = (Button) findViewById(R.id.show_ad );
		showBanner.setOnClickListener(VASTBannerSample.this);
		showBanner.setEnabled(false);
		showBanner.setText("Not Ready");
		setTitleColor(Color.WHITE);
		getSupportActionBar().setBackgroundDrawable(
				new ColorDrawable(Color.parseColor("#3498db")));
		SharedPreferences prefs = VASTBannerSample.this.getSharedPreferences(Constants.COM_SMAATO_DEMOAPP,
				Context.MODE_PRIVATE);
		videoAd.getAdSettings().setPublisherId(Integer.parseInt(prefs.getString(Constants.COM_SMAATO_DEMOAPP+Constants.PUBLISHER_ID, "0")));
		videoAd.getAdSettings().setAdspaceId(Integer.parseInt(prefs.getString(Constants.COM_SMAATO_DEMOAPP+Constants.AD_SPACE_ID, "0")));

		// will be autoclosed after 10 second. Default is 3 seconds
		videoAd.setAutoCloseDuration(10);

		// to completely disable AutoClose feature
/*		videoAd.disableAutoClose(true); */

		// configurable Video Skip Interval. Default is 15 seconds
        videoAd.setVideoSkipInterval(5);
	}

	@Override
	public void onClick(View v) {
		if (v == showBanner) {
			videoAd.show();
			showBanner.setEnabled(false);
			showBanner.setText("Not Ready");
			messageBoard.setText( "Ad shown" );
		}
		if (v == loadBanner) {

			if (Build.VERSION.SDK_INT > 22) {
				// check for permission and request user in runtime

				if(ActivityCompat.checkSelfPermission(this, Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {

					toast("Requesting Permission");

					// for VAST, carrier wifi is mandatory.
					String[] REQUIRED_PERMISSIONS = {Manifest.permission.READ_PHONE_STATE};
					ActivityCompat.requestPermissions(this, REQUIRED_PERMISSIONS , 1);

				} else {
					// permission already available
					messageBoard.setText( "Loading" );
					videoAd.asyncLoadNewBanner();
				}
			}else {
				messageBoard.setText( "Loading" );
				videoAd.asyncLoadNewBanner();
			}

		}
	}

	@Override
	public void onRequestPermissionsResult(int requestCode, String[] permissions , int[] grantResults){

		if( requestCode == 1 && grantResults.length ==1 && grantResults[0] == PackageManager.PERMISSION_GRANTED){
			toast("Permission granted");
			messageBoard.setText( "Loading" );
			videoAd.asyncLoadNewBanner();
		} else {
			toast("Permission denied");
		}
	}

	@Override
	public void onReadyToShow() {
		showBanner.setText("Ready to show");
		showBanner.setEnabled(true);
		toast("Ready to Show");
		messageBoard.setText( "Ad loaded" );
	}

	@Override
	public void onWillShow() {
		toast("on will show");
	}

	@Override
	public void onWillOpenLandingPage() {
		toast("onWillOpenLandingPage");
	}

	@Override
	public void onWillClose() {
		toast("on will close");
	}

	@Override
	public void onFailedToLoadAd() {
		messageBoard.setText( "Ad failed" );
		toast("Failed to load ad");
	}
	
	private void toast(final String msg) {
		this.runOnUiThread(new Runnable() {
			@Override
			public void run() {
				Toast.makeText(VASTBannerSample.this, msg,
						Toast.LENGTH_SHORT).show();
			}
		});
	}

	@Override
	public void onDestroy(){
		if(videoAd!=null){
			videoAd.destroy();
		}

		super.onDestroy();
	}
}
