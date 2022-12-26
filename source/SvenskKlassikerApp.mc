import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class SvenskKlassikerApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        var array = Application.loadResource(Rez.JsonData.vasa);
        var view = new SvenskKlassikerEventsView();
        return [ view, new SvenskKlassikerEventsDelegate(view) ] as Array<Views or InputDelegates>;
        // var view = new SvenskKlassikerView(array["workouts"][0]);
        // return [ view, new SvenskKlassikerDelegate(view) ] as Array<Views or InputDelegates>;
    }

}

function getApp() as SvenskKlassikerApp {
    return Application.getApp() as SvenskKlassikerApp;
}