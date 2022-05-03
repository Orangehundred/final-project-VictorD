package enemies;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;

class CenterEnemy extends Enemy 
{
    static private var SPEED = 75;

    var centerScreen:FlxPoint = new FlxPoint();

    public function new() {
        super();
        makeGraphic(30, 30, FlxColor.BLUE);
    }

    override private function setSpeed() {
        FlxVelocity.moveTowardsPoint(this, centerScreen, SPEED);
    }

    override function revive() {
        centerScreen.set(FlxG.width / 2, FlxG.height / 2);
        super.revive();
    }

    override private function shouldBeKilled() {
        var wouldParentBeKilled = super.shouldBeKilled();
        
        return wouldParentBeKilled || getMidpoint().distanceTo(centerScreen) < 2;//overlapsPoint(centerScreen);
    }
}