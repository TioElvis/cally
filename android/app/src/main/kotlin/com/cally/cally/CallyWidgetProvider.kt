package com.cally.cally

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.view.View
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider
import org.json.JSONArray
import java.text.DateFormatSymbols

/**
 * Cally Android home-screen widget: a minical-style month grid. Reads the data
 * the Flutter side wrote via home_widget (title / weekStart / grid / themeMode)
 * and fills a 6x7 grid where each day shows small event-title chips with long
 * titles ellipsised. Layout and ids are generated in res/layout/cally_widget.xml.
 *
 * Theme: in "System" mode the widget relies on theme-qualified resources
 * (@color/widget_fg and the background drawable both have -night variants), so
 * the launcher re-tints it the instant the phone flips light/dark — no re-add.
 * "Light"/"Dark" force explicit colours instead.
 */
class CallyWidgetProvider : HomeWidgetProvider() {

    // Event colour palette (keep in sync with lib/core/theme/tokens.dart).
    private val palette = intArrayOf(
        0xFF5B6CF0.toInt(), // indigo
        0xFF19B6A6.toInt(), // teal
        0xFF34B759.toInt(), // green
        0xFFF5A623.toInt(), // amber
        0xFFFF7A45.toInt(), // orange
        0xFFEC4E8C.toInt(), // pink
        0xFFA05BF0.toInt(), // purple
        0xFF64748B.toInt(), // slate
    )

    private fun colorFor(i: Int): Int = palette[((i % palette.size) + palette.size) % palette.size]

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences,
    ) {
        val pkg = context.packageName
        val res = context.resources
        fun id(name: String) = res.getIdentifier(name, "id", pkg)

        val title = widgetData.getString("title", "CALLY")
        val weekStart = (widgetData.getString("weekStart", "1") ?: "1").toIntOrNull() ?: 1
        val themeMode = (widgetData.getString("themeMode", "0") ?: "0").toIntOrNull() ?: 0
        val grid = try {
            JSONArray(widgetData.getString("grid", "[]"))
        } catch (e: Exception) {
            JSONArray()
        }

        // null = "System": leave the layout's theme-qualified resources alone so
        // the launcher swaps them live; otherwise force the chosen colour.
        val forcedFg: Int? = when (themeMode) {
            1 -> 0xFF1A1A1A.toInt()
            2 -> 0xFFFFFFFF.toInt()
            else -> null
        }
        val bgRes = when (themeMode) {
            1 -> R.drawable.cally_widget_bg_light
            2 -> R.drawable.cally_widget_bg_dark
            else -> R.drawable.cally_widget_bg // has a -night variant
        }
        val outColor = 0x808B949E.toInt() // muted grey, readable on both themes

        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(pkg, R.layout.cally_widget)
            views.setInt(R.id.widget_root, "setBackgroundResource", bgRes)
            views.setTextViewText(R.id.widget_title, title)
            if (forcedFg != null) views.setTextColor(R.id.widget_title, forcedFg)

            // Weekday header, localised, ordered from the chosen week start.
            val letters = weekdayLetters(weekStart)
            for (i in 0 until 7) {
                views.setTextViewText(id("wd_$i"), letters[i])
            }

            // 42 cells.
            for (n in 0 until 42) {
                val cell = grid.optJSONObject(n)
                val dayId = id("day_$n")
                if (cell == null) {
                    views.setTextViewText(dayId, "")
                    continue
                }
                val d = cell.optInt("d")
                val out = cell.optBoolean("out")
                val today = cell.optBoolean("today")
                views.setTextViewText(dayId, d.toString())

                when {
                    today -> {
                        views.setInt(dayId, "setBackgroundResource", R.drawable.cally_today_bg)
                        views.setTextColor(dayId, 0xFFFFFFFF.toInt())
                    }
                    out -> {
                        views.setInt(dayId, "setBackgroundResource", 0)
                        views.setTextColor(dayId, outColor)
                    }
                    else -> {
                        views.setInt(dayId, "setBackgroundResource", 0)
                        // System mode keeps @color/widget_fg from the layout.
                        if (forcedFg != null) views.setTextColor(dayId, forcedFg)
                    }
                }

                val labels = cell.optJSONArray("labels") ?: JSONArray()
                val shown = minOf(labels.length(), 2)
                for (li in 0 until 2) {
                    val lblId = id("l${li}_$n")
                    if (li < shown) {
                        val l = labels.getJSONObject(li)
                        views.setTextViewText(lblId, l.optString("t"))
                        views.setTextColor(lblId, colorFor(l.optInt("c")))
                        views.setViewVisibility(lblId, View.VISIBLE)
                    } else {
                        views.setViewVisibility(lblId, View.GONE)
                    }
                }

                val hidden = cell.optInt("more") + maxOf(0, labels.length() - 2)
                val moreId = id("more_$n")
                if (hidden > 0) {
                    views.setTextViewText(moreId, "+$hidden")
                    views.setViewVisibility(moreId, View.VISIBLE)
                } else {
                    views.setViewVisibility(moreId, View.GONE)
                }
            }

            // Open the app with the launcher's own intent (same as tapping the
            // app icon, which never duplicates) rather than a custom widget
            // intent that could start a second task — the "opens twice" bug.
            val launch = context.packageManager.getLaunchIntentForPackage(pkg)
            if (launch != null) {
                val pending = PendingIntent.getActivity(
                    context, 0, launch,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
                views.setOnClickPendingIntent(R.id.widget_root, pending)
            }

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }

    /** Localised one-letter weekday headers, ordered from [weekStart] (1=Mon..7=Sun). */
    private fun weekdayLetters(weekStart: Int): List<String> {
        val short = DateFormatSymbols.getInstance().shortWeekdays // [_, Sun, Mon .. Sat]
        // Monday-first indices into `short`: Mon=2,Tue=3,Wed=4,Thu=5,Fri=6,Sat=7,Sun=1.
        val mondayFirst = intArrayOf(2, 3, 4, 5, 6, 7, 1)
        val offset = (weekStart - 1).coerceIn(0, 6)
        return (0 until 7).map { i ->
            val s = short.getOrNull(mondayFirst[(offset + i) % 7]) ?: ""
            if (s.isEmpty()) "" else s.substring(0, 1).uppercase()
        }
    }
}
