package com.smaato.demoapp.activities;

import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.webkit.WebView;

public class AboutActivity extends ActionBarActivity {
	WebView mWebView;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		mWebView = new WebView(AboutActivity.this);
		mWebView.loadUrl("http://www.smaato.com/company/");
		setContentView(mWebView);
		setTitleColor(Color.WHITE);
		getSupportActionBar().setBackgroundDrawable(new ColorDrawable(Color.parseColor("#3498db")));
	}
}
