package com.example.onlycation_app

import android.content.Context
import android.view.LayoutInflater
import android.widget.Button
import android.widget.ImageView
import android.widget.TextView
import com.example.onlycation_app.R
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class NativeAdFactoryExample(private val context: Context) : GoogleMobileAdsPlugin.NativeAdFactory {
    override fun createNativeAd(nativeAd: NativeAd, customOptions: MutableMap<String, Any>?): NativeAdView {
        val adView = LayoutInflater.from(context).inflate(R.layout.native_ad_layout, null) as NativeAdView

        val headlineView = adView.findViewById<TextView>(R.id.ad_headline)
        val bodyView = adView.findViewById<TextView>(R.id.ad_body)
        val callToActionView = adView.findViewById<Button>(R.id.ad_call_to_action)
        val iconView = adView.findViewById<ImageView>(R.id.ad_app_icon)

        adView.headlineView = headlineView
        adView.bodyView = bodyView
        adView.callToActionView = callToActionView
        adView.iconView = iconView

        headlineView.text = nativeAd.headline
        bodyView.text = nativeAd.body ?: ""
        callToActionView.text = nativeAd.callToAction ?: "Ver"

        val icon = nativeAd.icon
        if (icon != null) {
            iconView.setImageDrawable(icon.drawable)
            iconView.visibility = android.view.View.VISIBLE
        } else {
            iconView.visibility = android.view.View.GONE
        }

        adView.setNativeAd(nativeAd)
        return adView
    }
}
