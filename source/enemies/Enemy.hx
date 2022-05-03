package enemies;

import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;


class Enemy extends FlxSprite
{
    static var SPEED:Float = 150;

	public function new()
    {
        super(x,y);
		loadGraphic(AssetPaths.enemy__png, false);
        kill();
    } 

    private function setSpeed() {
        velocity.x = 150;
        velocity.y = 150;
    }

    override public function revive()
    {
        angularVelocity = 200;
        setSpeed();

        //PLAN TO IMPLEMENT FOR LOOP THAT SPAWNS ENEMIES IN A CIRCLE AROUND CENTER POINT
        
        super.revive();
    }

    private function shouldBeKilled():Bool {
        return !isOnScreen();
    }

    override public function update(elapsed:Float)
    {
        if (shouldBeKilled())
        {
            kill();
        }

        super.update(elapsed);
    }

    // If Enemy overlaps center of screen
    public static function overlapsWithCenter(center:FlxObject, enemy:Enemy)
    {
		enemy.kill();
    }
}