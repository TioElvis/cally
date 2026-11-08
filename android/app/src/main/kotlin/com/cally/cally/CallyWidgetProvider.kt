package com.cally.cally

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider
import org.json.JSONArray

/**
 * Cally Android home-screen widget. Reads the data the Flutter side wrote via
 * home_widget (keys title/todayCount/upcoming) and renders a compact summary.
 * A full month grid in RemoteViews is possible later; this keeps M4 shippable.
 */
class CallyWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences,
    ) {
        appWidgetIds.forEach { id ->
            val views = RemoteViews(context.packageName, R.layout.cally_widget).apply {
                setTextViewText(R.id.widget_title, widgetData.getString("title", "CALLY"))
                val count = widgetData.getString("todayCount", "0")
                setTextViewText(R.id.widget_today, "$count today")
                setTextViewText(R.id.widget_next, firstTitle(widgetData.getString("upcoming", "[]")))

                val pending = HomeWidgetLaunchIntent.getActivity(
                    context, MainActivity::class.java, Uri.parse("cally://today"))
                setOnClickPendingIntent(R.id.widget_root, pending)
            }
            appWidgetManager.updateAppWidget(id, views)
        }
    }

    private fun firstTitle(json: String?): String = try {
        val a = JSONArray(json)
        if (a.length() == 0) "No upcoming events" else "Next: " + a.getJSONObject(0).getString("t")
    } catch (e: Exception) {
        ""
    }
}
