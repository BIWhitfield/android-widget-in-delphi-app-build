# android-widget-in-delphi-app-build
POC for adding an Android homescreen widget to an Android app built with Delphi (Berlin). The current build in Delphi runs the widget with no crashes but fails to load the TextView which is being updated via the RemoteViews object in the widget code.
To test where the project is up to, run up the Delphi project and build for debug to a device. This should load the App on to the device. Then add the widget to the homescreen. You'll see a blank widget, that doesn't crash but does log the update call if you check the device using logcat in Android Studio.

If making changes to the widget code you will need to create a new build and .jar file to be copied to the Delphi project after each change.

**Android Widget**
<br>
* Open, make changes to source code then - clean and build androidWidgetTest app in Android Studio.
* From Gradle menu on right hand side select and run androidwidgettest > Tasks > other > "createJar" 
<br>
This will create the .jar file you need to put in the Delphi project. Any file that has had a change made to it will need copying over to the Delphi project also. This includes any layout files, drawables, and classes. 
<br>
<br>

**Delphi**

* Open Delphi

* Remove widget01.jar from the project by right clicking and deleting it in the project structure panel - androidwidgettest > target Platforms > Android > Libraries

* Copy the widget01.jar file from the Android project to the main project folder for the Delphi app. Then drag and drop that new .jar file in to the libraries file to add it to the project.

* In a new file window navigate to the Delphi project folder and Delete all folders inside the Android folder in the main Delphi app folder (debug, obj, src)

* Replace any other files changed in the Android studio project in the widget01 > Services folder. If changes have been made to the widget01.class in the Android Studio project copy this in to the widget01\Services\AndroidWidgets\src\main\java\uk\co\mybuzztechnologies\androidwidgettest folder.

* All other assets go in the widget01\Services\AndroidWidgets\src\main\res folder. This inlcudes layouts, drawbales, xml files etc.

<br><br>
The Delphi app has a post compile script running to ensure that the R.java file and any relevant classes needed are compiled in to the project. This should run automatically and recreate the folders you deleted from the Android folder (debug, obj, src) when running a debug build. It should then delpoy to the device and you can test dragging a widget to the home screen.

At this point the app shouldn't crash but the TextView that is updating when deploying straight to the device from Android Studio will not appear. Checks made in the logcat should show the logs that prove onUpdate is being called with no errors.
