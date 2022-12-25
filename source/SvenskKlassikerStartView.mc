import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Timer;
import Toybox.WatchUi;
import Toybox.Attention;



class SvenskKlassikerStartView extends WatchUi.View {
    var wo;

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

        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_BLACK);
        dc.clear();

        for(var i = 0; i < wo.size(); i++){
            dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
            dc.fillRectangle(0, i * height / wo.size(), width, height / wo.size());
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.drawText(width/2, i * height / wo.size() + height / (wo.size()*2), Graphics.FONT_SMALL, wo[i]["name"] + " " + wo[i]["duration"] + "min/rep", Graphics.TEXT_JUSTIFY_CENTER);
            dc.drawLine(0, i*(height / wo.size()), width, i*(height / wo.size()));
        }
       
    }

   
}
