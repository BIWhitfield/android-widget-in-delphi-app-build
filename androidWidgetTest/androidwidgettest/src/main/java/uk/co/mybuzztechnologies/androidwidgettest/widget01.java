package uk.co.mybuzztechnologies.androidwidgettest;

import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.ComponentName;
import android.content.Context;
import android.util.Log;
import android.widget.RemoteViews;

/**
 * Implementation of App Widget functionality.
 */
public class widget01 extends AppWidgetProvider {

    @Override
    public void onUpdate(Context context, AppWidgetManager appWidgetManager, int[] appWidgetIds) {
        int[] realAppWidgetIds = AppWidgetManager.getInstance(context).getAppWidgetIds(new ComponentName(context, widget01.class));
        // There may be multiple widgets active, so update all of them
        for (int appWidgetId : realAppWidgetIds) {

            RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.widget01);
            Log.w(views.toString(), "VIEWS MESSAGE");
            views.setTextViewText(R.id.texty_texty, "Say hello to my little appwidget");

            Log.w("UpdateAppWidget","textView? Who knows!");

//            ComponentName widget = new ComponentName(context, widget01.class);
//            AppWidgetManager.updateAppWidget(new ComponentName(context, widget01.class), views);

            ComponentName componentName = new ComponentName(context, widget01.class);
            AppWidgetManager.getInstance(context).updateAppWidget(componentName, views);

//            AppWidgetManager.getInstance(context).updateAppWidget(new ComponentName(context, widget01.class), views);

//            AppWidgetManager.getInstance(context).updateAppWidget(appWidgetId, views);
            //AppWidgetManager.updateAppWidget(appWidgetId, views);
        }
        Log.w("Update","Update Finished");
        super.onUpdate(context, appWidgetManager, realAppWidgetIds);
    }

    @Override
    public void onEnabled(Context context) {
        // Enter relevant functionality for when the first widget is created
    }

    @Override
    public void onDisabled(Context context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}

