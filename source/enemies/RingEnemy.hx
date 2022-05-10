package enemies;

import flixel.math.FlxVelocity;
import flixel.FlxObject;

class RingEnemy extends CenterEnemy {

    static private var SPEED = 125;

    public function new() {
        super();
		loadGraphic(AssetPaths.ringEnemy__png, false);
    }

    override function revive() {
        super.revive();
        angularVelocity = 300;
        
    }

    override private function setSpeed() {
        FlxVelocity.moveTowardsPoint(this, centerScreen, SPEED);
    }

    public static function overlapsWithPlayer(player:FlxObject, enemy:Enemy)
        {
            player.hurt(1);
            enemy.kill();
            //FlxG.sound.play(AssetPaths.PlayerHurt__wav, .80);
        }
}