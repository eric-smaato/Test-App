package com.smaato.demoapp;

import android.app.Activity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

public class CustomList extends ArrayAdapter<String> {
	private final Activity context;
	private final String[] text;
	private final Integer[] imageId;
	private final boolean isMainMenu;
	
	public CustomList(Activity context, String[] text, Integer[] imageId,boolean isMainMenu) {
		super(context, R.layout.list_single, text);
		this.context = context;
		this.text = text;
		this.imageId = imageId;
		this.isMainMenu = isMainMenu;
	}

	@Override
	public View getView(int position, View view, ViewGroup parent) {

		ViewHolderItem viewHolderItem = null;

		if(view == null){
			LayoutInflater inflater = context.getLayoutInflater();
			if(!isMainMenu){
				view = inflater.inflate(R.layout.config_list, null, true);
			}
			else {
				view = inflater.inflate(R.layout.list_single, null, true);
			}

			viewHolderItem = new ViewHolderItem();

			viewHolderItem.txtTitle = (TextView) view.findViewById(R.id.txt);
			viewHolderItem.imageView = (ImageView) view.findViewById(R.id.img);

			view.setTag( viewHolderItem );
		} else {
			viewHolderItem = (ViewHolderItem) view.getTag();
		}

		viewHolderItem.txtTitle.setText(text[position]);
		if(!isMainMenu){
			viewHolderItem.txtTitle.setTextColor(context.getResources().getColor( R.color.trans ));
			viewHolderItem.txtTitle.setBackgroundColor(context.getResources().getColor( R.color.black ));
			viewHolderItem.imageView.setBackgroundColor(  context.getResources().getColor( R.color.black_dark));
			((RelativeLayout)viewHolderItem.imageView.getParent()).setBackgroundColor(context.getResources().getColor( R.color.black_dark ));
		} else{
			viewHolderItem.txtTitle.setTextColor(context.getResources().getColor( R.color.grey ));
			viewHolderItem.txtTitle.setBackgroundColor(context.getResources().getColor( R.color.grey_medium ));
			viewHolderItem.imageView.setBackgroundColor( context.getResources().getColor( R.color.grey_light ));
			((RelativeLayout)viewHolderItem.imageView.getParent()).setBackgroundColor(  context.getResources().getColor( R.color.grey_light ));
		}
		viewHolderItem.imageView.setImageResource(imageId[position]);
		return view;
	}

	static class ViewHolderItem {
		TextView txtTitle;
		ImageView imageView;
	}
}
