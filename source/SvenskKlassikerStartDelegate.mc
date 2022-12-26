import Toybox.Lang;
import Toybox.WatchUi;

class SvenskKlassikerStartDelegate extends WatchUi.BehaviorDelegate {
    var workouts;
    var view;
    var curr_workout = 0;
    function initialize(view_, event_data) {
        BehaviorDelegate.initialize();
        view = view_;
        workouts = Application.loadResource(event_data)["workouts"];
        for (var i = 0; i < workouts.size(); i++) {
            var duration as Number = 0;
            for (var n = 0; n < workouts[i]["routine"].size(); n++) {
                duration += workouts[i]["routine"][n]["time"];
            }
            workouts[i]["duration"] = (duration)/60;

        }
        view.workout = workouts[curr_workout];
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

      function onSwipe(swipeEvent as WatchUi.SwipeEvent){
        var dir = swipeEvent.getDirection();
        if(dir == 1){
            curr_workout--;
            if(curr_workout< 0){
                curr_workout = 0;
            }
            view.change_workout(workouts[curr_workout]);
        }else if(dir == 3){
            ++curr_workout;
            curr_workout =curr_workout  % workouts.size();
            System.println(curr_workout);
            
            view.change_workout(workouts[curr_workout]);
        }
        return true;
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new SvenskKlassikerMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }
    

}