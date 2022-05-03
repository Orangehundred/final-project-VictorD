package enemies;

import flixel.math.FlxVelocity;
import flixel.util.FlxColor;

class RingEnemy extends CenterEnemy {

    static private var SPEED = 125;

    public function new() {
        super();
        makeGraphic(30, 30, FlxColor.YELLOW);
    }

    override private function setSpeed() {
        FlxVelocity.moveTowardsPoint(this, centerScreen, SPEED);
    }
}