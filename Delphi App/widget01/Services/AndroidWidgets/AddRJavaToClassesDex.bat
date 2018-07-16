REM @echo OFF
setlocal ENABLEEXTENSIONS
set JDKPath="C:\Program Files\Java\jdk1.7.0_25\bin"

REM -- SDKAaptPath is passed by Delphi as an expansion of its internal SDKAaptPath variable
set SDKAaptPath=%3
@echo SDKAaptPath = %SDKAaptPath%

REM -- SDKApiLevelPath is passed by Delphi as an expansion of its internal SDKApiLevelPath variable
set SDKApiLevelPath=%4
@echo SDKApiLevelPath = %SDKApiLevelPath%

REM -- JavaDxPath is passed by Delphi as an expansion of its internal JavaDxPath variable
set JavaDxPath=%5
@echo JavaDxPath = %JavaDxPath%

REM -- Delete existing R.java related classes
rmdir /Q /S %1\Android\src
rmdir /Q /S %1\Android\obj
mkdir %1\Android\src
mkdir %1\Android\obj

REM -- Create R.java for resources for Widget
%SDKAaptPath% package -f -m -M %1\Services\AndroidWidgets\src\main\AndroidManifest.xml -I %SDKApiLevelPath% -S %1\Services\AndroidWidgets\src\main\res -J %1\Android\src

REM -- Compile R.java into R$ classes for Widget
%JDKPath%\javac -verbose -d %1\Android\obj -classpath %SDKApiLevelPath%;%1\Android\obj -sourcepath %1\Android\src %1\Android\src\uk\co\mybuzztechnologies\androidwidgettest\*.java

REM -- Rebuild the classes.dex to include the R$ classes ** must add all the jars in the library and the path to the R$ class files

%JavaDxPath% --dex --verbose --output=%1\Android\%2\classes.dex "c:\program files (x86)\embarcadero\studio\18.0\lib\Android\Release\cloud-messaging.dex.jar" "c:\program files (x86)\embarcadero\studio\18.0\lib\Android\Release\fmx.dex.jar" "c:\program files (x86)\embarcadero\studio\18.0\lib\Android\Release\google-analytics-v2.dex.jar" "c:\program files (x86)\embarcadero\studio\18.0\lib\Android\Release\google-play-billing.dex.jar" "c:\program files (x86)\embarcadero\studio\18.0\lib\Android\Release\google-play-licensing.dex.jar" "c:\program files (x86)\embarcadero\studio\18.0\lib\Android\Release\google-play-services.dex.jar" "c:\program files (x86)\embarcadero\studio\18.0\lib\Android\Release\android-support-v4.dex.jar" %1\Android\%2\widget01-dexed.jar %1\Android\obj

REM %JavaDxPath% --dex --verbose --output=%1\Android\%2\classes.dex "c:\program files (x86)\embarcadero\studio\18.0\lib\Android\Release\cloud-messaging.dex.jar" "c:\program files (x86)\embarcadero\studio\18.0\lib\Android\Release\fmx.dex.jar" "c:\program files (x86)\embarcadero\studio\18.0\lib\Android\Release\google-analytics-v2.dex.jar" "c:\program files (x86)\embarcadero\studio\18.0\lib\Android\Release\google-play-billing.dex.jar" "c:\program files (x86)\embarcadero\studio\18.0\lib\Android\Release\google-play-licensing.dex.jar" "c:\program files (x86)\embarcadero\studio\18.0\lib\Android\Release\google-play-services.dex.jar" %1\Android\obj

echo "Output file is at: %1\Android\%2\classes.dex"