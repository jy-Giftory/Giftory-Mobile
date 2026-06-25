package com.example.giftory

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin
import es.antonborri.home_widget.HomeWidgetProvider

class GiftoryWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: android.content.SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.giftory_widget).apply {
                val title = widgetData.getString("title", "등록된 기념일이 없어요")
                val dday = widgetData.getString("dday", "")
                val subtitle = widgetData.getString("subtitle", "기념일을 추가해보세요")

                setTextViewText(R.id.widget_title, title)
                setTextViewText(R.id.widget_subtitle, subtitle)

                if (dday.isNullOrEmpty()) {
                    setViewVisibility(R.id.widget_dday, android.view.View.GONE)
                } else {
                    setViewVisibility(R.id.widget_dday, android.view.View.VISIBLE)
                    setTextViewText(R.id.widget_dday, dday)
                }

                // 위젯 탭 시 앱 실행
                val launchIntent = context.packageManager
                    .getLaunchIntentForPackage(context.packageName)
                if (launchIntent != null) {
                    val pendingIntent = PendingIntent.getActivity(
                        context,
                        0,
                        launchIntent,
                        PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                    )
                    setOnClickPendingIntent(R.id.widget_title, pendingIntent)
                }
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
