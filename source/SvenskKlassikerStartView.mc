import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Timer;
import Toybox.WatchUi;
import Toybox.Attention;



class SvenskKlassikerStartView extends WatchUi.View {
    var workout;

    //! Constructor
    public function initialize() {
        WatchUi.View.initialize();
       
    }


    //! Load your resources here
    //! @param dc Device context
    public function onLayout(dc as Dc) as Void {
       
        
    }




    //! Update the view
    //! @param dc Device Context
    public function onUpdate(dc as Dc) as Void {
        var height = dc.getHeight();
        var width = dc.getWidth();
        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_WHITE);
        dc.clear();

        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.drawText(width/2, height/3 , Graphics.FONT_MEDIUM, workout["name"], Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(width/2, height*2/3 , Graphics.FONT_SMALL, workout["duration"] + "min/rep", Graphics.TEXT_JUSTIFY_CENTER);
    }

    public function change_workout(workout){
        me.workout = workout;
        WatchUi.requestUpdate();

    }

   
}
