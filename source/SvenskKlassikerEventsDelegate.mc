import Toybox.Lang;
import Toybox.WatchUi;

class SvenskKlassikerEventsDelegate extends WatchUi.BehaviorDelegate {
    var events;
    var view;
    var event_nmbr = 0;

    var event_data = [Rez.JsonData.vasa, Rez.JsonData.vatternrundan, Rez.JsonData.swiming, Rez.JsonData.run];

    function initialize(view_) {
        BehaviorDelegate.initialize();
        view = view_;
        events = Application.loadResource(Rez.JsonData.events)["events"];
        view.events = events;
        view.change_event(event_nmbr);
    }

    

    function onTap(evt as ClickEvent){
        var view = new SvenskKlassikerStartView();
        WatchUi.pushView( view, new SvenskKlassikerStartDelegate(view, event_data[event_nmbr]) , WatchUi.SLIDE_UP);
        
    }

      function onSwipe(swipeEvent as WatchUi.SwipeEvent){
        var dir = swipeEvent.getDirection();
        if(dir == 1){
            event_nmbr--;
            if(event_nmbr< 0){
                event_nmbr = 0;
            }
            view.change_event(event_nmbr);
        }else if(dir == 3){
            ++event_nmbr;
            event_nmbr =event_nmbr  % event_data.size();
            
            view.change_event(event_nmbr);
        }
        return true;
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new SvenskKlassikerMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }
    

}