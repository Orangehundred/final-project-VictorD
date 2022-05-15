package enemies;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;
import flixel.FlxObject;

class CenterEnemy extends Enemy 
{
    static private var SPEED = 75;

    var centerScreen:FlxPoint = new FlxPoint();

    public function new() {
        super();

		loadGraphic(AssetPaths.centerEnemy__png, false);
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

    public static function overlapsWithPlayer(player:FlxObject, enemies:Enemy)
        {
            player.hurt(1);
            enemies.kill();
            //FlxG.sound.play(AssetPaths.PlayerHurt__wav, .80);
        }
}