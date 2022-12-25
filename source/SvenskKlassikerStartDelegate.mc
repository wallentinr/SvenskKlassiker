import Toybox.Lang;
import Toybox.WatchUi;

class SvenskKlassikerStartDelegate extends WatchUi.BehaviorDelegate {
    var workouts;
    var view;
    function initialize(view_) {
        BehaviorDelegate.initialize();
        view = view_;
        workouts = Application.loadResource(Rez.JsonData.jsonFile)["workouts"];
        for (var i = 0; i < workouts.size(); i++) {
            var duration as Number = 0;
            for (var n = 0; n < workouts[i]["routine"].size(); n++) {
                duration += workouts[i]["routine"][n]["time"];
            }
            workouts[i]["duration"] = (duration)/60;

        }
        view.wo = workouts;
    }

    public function getWorkoutFromY(ycoord as Number) {
        var height = System.getDeviceSettings().screenHeight;
        var i;
        for(i = 0; i < workouts.size(); i++){
            var h = (i+1)*height/workouts.size();
            if(ycoord < h){
                break;
            }
        }

        return i;
    }

    function onTap(evt as ClickEvent){
        var ycoords = evt.getCoordinates()[1];
        var view = new SvenskKlassikerView(workouts[getWorkoutFromY(ycoords)]);
         WatchUi.pushView( view, new SvenskKlassikerDelegate(view) , WatchUi.SLIDE_UP);
        
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new SvenskKlassikerMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }
    

}