import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Timer;
import Toybox.WatchUi;
import Toybox.Attention;

import Toybox.Time;
import Toybox.Time.Gregorian;


class SvenskKlassikerEventsView extends WatchUi.View {
    var event;
    var events;
    var event_image as Bitmap;

    var images = [Rez.Drawables.skiing, Rez.Drawables.bike, Rez.Drawables.swim, Rez.Drawables.run_img];

    //! Constructor
    public function initialize() {
        WatchUi.View.initialize();
    }

    public function change_event(event_nmbr){
        me.event = events[event_nmbr];
        me.event_image = Application.loadResource(images[event_nmbr]) as BitmapResource;
        WatchUi.requestUpdate();

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

        dc.drawBitmap(width/2-50, height/2-50, event_image);
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.drawText(width/2, height /5, Graphics.FONT_SMALL, event["name"], Graphics.TEXT_JUSTIFY_CENTER);
        
        var year = event["year"];
        var month = event["month"];
        var day = event["day"];
        var date_opt = {
            :year   => year,
            :month  => month,
            :day    => day
        };
        var date = Gregorian.moment(date_opt);

        var today = Time.now();
        var diff = date.subtract(today).value() / (3600*24);

        dc.drawText(width/2, height*4 /5, Graphics.FONT_SMALL, (diff).toString() + " days left", Graphics.TEXT_JUSTIFY_CENTER);

    }

   
}
