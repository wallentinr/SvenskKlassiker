import Toybox.Lang;
import Toybox.WatchUi;

class SvenskKlassikerDelegate extends WatchUi.BehaviorDelegate {
    var view as SvenskKlassikerView;
    function initialize(view_) {
        view = view_;
        BehaviorDelegate.initialize();
    }

    function onTap(evt as ClickEvent){
        // System.println(SvenskKlassikerView.currWorkout;);
        var coords = evt.getCoordinates();

        view.screenTap(coords);

    }

    function onKeyPressed(clickEvent){
        view.btnPress(clickEvent.getKey());
        
    }

    function onSwipe(swipeEvent as WatchUi.SwipeEvent){
        view.screenSwipe(swipeEvent.getDirection()); // e.g. SWIPE_DOWN = 2
        return true;

    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new SvenskKlassikerMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }
    

}