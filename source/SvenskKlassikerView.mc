import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Timer;
import Toybox.WatchUi;
import Toybox.Attention;

class Workout{
    var name;
    var time;
    public function initialize( name, time ) {
      me.name = name;
      me.time = time;
    }
}

class SvenskKlassikerView extends WatchUi.View {
    var vibrateData = [
                new Attention.VibeProfile(25, 100),
                new Attention.VibeProfile(50, 100),
                new Attention.VibeProfile(75, 100),
                new Attention.VibeProfile(100, 100),
                new Attention.VibeProfile(75, 100),
                new Attention.VibeProfile(50, 100),
                new Attention.VibeProfile(25, 100)
                ] as Array<VibeProfile>;
    private var _timer1 as Timer.Timer?;
    private var _count1 as Number = 5;
    var currWorkout as Number = 0;
    var workouts = [] as Array<Workout>;
    var numTimes as Number = 1;
    var current_state as Number = 0;
    var num_reps as Number = 3;
    var curr_rep as Number = 0;

    var time_height as Number = 0;
    var wo_height as Number = 0;
    var next_wo_height as Number = 0;
    var horizontal_center as Number = 0;
    var paused as Boolean = false;
    var workout;

    var status_timer = 0;
    var play_image as Bitmap;
    
    //! Constructor
    public function initialize(workout_) {
        workout = workout_;
        WatchUi.View.initialize();
        var timer1 = new Timer.Timer();
        _timer1 = timer1;
        play_image = Application.loadResource( Rez.Drawables.play_img ) as BitmapResource;
       
    }
    function prev_workout(){
        if(_count1 < workouts[currWorkout].time || currWorkout == 0  && curr_rep == 0){
            _count1 = workouts[currWorkout].time;
        }else{
            if(currWorkout == 0){
                currWorkout = workouts.size()-1;
                curr_rep --;
                _count1 = workouts[currWorkout].time;

            }else{
                currWorkout--;
                _count1 = workouts[currWorkout].time;
            }
        }
    }

    function next_workout(){
        currWorkout++;
        if(currWorkout ==  workouts.size()){
            curr_rep++;
            if(curr_rep == num_reps){
                currWorkout = 0;
                
                var timer = _timer1;
                timer.stop();
                current_state = 2;
                return 1;

            }else{
                currWorkout = 0;
            }
            _count1 = workouts[0].time;
        }else{
            _count1 = workouts[currWorkout].time;
        }
        return 0;
    }
    //! Callback for timer 1
    public function tim_callback() as Void {
        _count1--;
        status_timer--;

        if(_count1 == 0){
         
            Attention.vibrate(vibrateData);
            
            if(next_workout() == 1){
                Attention.vibrate(vibrateData);
            }

        }
        WatchUi.requestUpdate();
    }

    //! Load your resources here
    //! @param dc Device context
    public function onLayout(dc as Dc) as Void {
        time_height = dc.getHeight()/3;
        wo_height = dc.getHeight() / 5;
        next_wo_height = dc.getHeight()*4 /5;
        horizontal_center = dc.getWidth()/2;
        num_reps = workout["reps"];

        for(var i = 0; i < workout["routine"].size(); i++){
            var name = workout["routine"][i]["name"];
            var time = workout["routine"][i]["time"];
            workouts.add(new Workout(name, time));
        }

        _count1 = workouts[0].time;

        
    }

    public function start_scene(dc){
        var startBtnX = dc.getWidth()*8/9;
        var startBtnY = dc.getHeight()/4;
        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(startBtnX, startBtnY, dc.getHeight()/8);
        dc.drawBitmap(startBtnX*0.90, startBtnY*0.80, play_image);
        
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(horizontal_center, (dc.getHeight()/3), Graphics.FONT_MEDIUM, 
                workout["name"] + "\n" + "reps: " + num_reps + "  " + workout["duration"] * num_reps + " min", 
                Graphics.TEXT_JUSTIFY_CENTER);
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(horizontal_center, (dc.getHeight()*2/3), 
            Graphics.FONT_SMALL, workouts[currWorkout].name ,Graphics.TEXT_JUSTIFY_CENTER);

    }

    public function on_scene(dc){
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        var string = _count1;
        dc.drawText(horizontal_center, wo_height, Graphics.FONT_MEDIUM, workouts[currWorkout].name, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(horizontal_center, time_height, Graphics.FONT_NUMBER_THAI_HOT, string, Graphics.TEXT_JUSTIFY_CENTER);
        if(currWorkout <  workouts.size()-1){
            dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
            dc.drawText(horizontal_center, (next_wo_height), Graphics.FONT_SMALL, workouts[currWorkout+1].name, Graphics.TEXT_JUSTIFY_CENTER);
        }else if(curr_rep < num_reps-1){
            dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
            dc.drawText(horizontal_center, (next_wo_height), Graphics.FONT_SMALL, workouts[0].name, Graphics.TEXT_JUSTIFY_CENTER);
        
        }else{
               dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
            dc.drawText(horizontal_center, (next_wo_height), Graphics.FONT_SMALL, "FINISHED", Graphics.TEXT_JUSTIFY_CENTER);
        }

        if(status_timer > 0){
            dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);

            dc.drawText(horizontal_center, 30, Graphics.FONT_SYSTEM_XTINY, 
                "exercise:" + (currWorkout+1).toString() + "/" + (workouts.size()).toString() + 
                " repetition:" + (curr_rep+1).toString() + "/" + (num_reps+1).toString(), 
                Graphics.TEXT_JUSTIFY_CENTER);

        }

        if (paused){
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

            var startBtnX = dc.getWidth()*11/12;
            var startBtnY = dc.getHeight()/4;
            var lineLength = 20;
            var linewidth = 5;
            var lineBetween = 10;
            dc.fillRectangle(startBtnX,startBtnY, linewidth, lineLength);
            dc.fillRectangle(startBtnX-lineBetween,startBtnY, linewidth, lineLength);
        }
    }

     public function end_scene(dc){
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

        dc.drawText(horizontal_center, (dc.getHeight()/ 2), Graphics.FONT_MEDIUM, "YOU ROCK!", Graphics.TEXT_JUSTIFY_CENTER);
        
    }

    public function screenTap(coords){
     

    }

    public function screenSwipe(dir){
        if(current_state == 1){

            if(dir == 2){
                status_timer = 4;
            }
            else if(dir == 1){
                prev_workout();
                _timer1.start(method(:tim_callback), 1000, true);
            }else if(dir == 3){
                 next_workout();
                _timer1.start(method(:tim_callback), 1000, true);
            }
            WatchUi.requestUpdate();
        }
        else if(current_state == 0){
            if(dir == 0){
                num_reps ++;
            }else if (dir == 2 && num_reps > 1){
                num_reps --;
            }
            WatchUi.requestUpdate();
        }
    }

    public function btnPress(btn) as Void {
        if(btn == 4){
            if(current_state == 0){
                
                _timer1.start(method(:tim_callback), 1000, true);
                current_state = 1;
                Attention.vibrate(vibrateData);

            }else if(current_state == 1){
                paused = !paused;
                if(paused){
                    stopTimer();
                }else{
                    startTimer();
                }
                WatchUi.requestUpdate();
            }else if (current_state == 2){
            current_state = 0;
            }
        }else if(btn == 5){
            _timer1.stop();
        }
        
    }

    //! Update the view
    //! @param dc Device Context
    public function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_BLACK);

        dc.clear();
        if(current_state == 0){
            start_scene(dc);
        }else if(current_state == 1){
            on_scene(dc);
        }else if (current_state == 2){
            end_scene(dc);
        }
       
    }

    //! Stop the first timer
    public function stopTimer() as Void {
        var timer = _timer1;
        if (timer != null) {
            timer.stop();
        }
    }

    public function startTimer() as Void {
        var timer = _timer1;
        if (timer != null) {
            timer.start(method(:tim_callback), 1000, true);
        }
    }
}
