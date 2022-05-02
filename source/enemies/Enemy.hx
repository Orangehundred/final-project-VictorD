package enemies;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;


class Enemy extends FlxSprite
{
    static var SPEED:Float = 75;

	public function new()
    {
        super(x,y);
		loadGraphic(AssetPaths.enemy__png, false);
        kill();
    } 

    override public function revive()
    {
        x = FlxG.random.int(250, 750);
        y = FlxG.random.int(250, 750);
        velocity.x = 150;
        velocity.y = 150;
        angularVelocity = 200;

        //PLAN TO IMPLEMENT FOR LOOP THAT SPAWNS ENEMIES IN A CIRCLE AROUND CENTER POINT
        
        super.revive();
    }

    override public function update(elapsed:Float)
    {
	if (movedOffScreenY() && movedOffScreenX())
    {
        kill();
    }
    super.update(elapsed);
    }

    // Returns value of off Y axis of screen
    private function movedOffScreenY()
    {
        return y + height < FlxG.camera.scroll.y;
    }

    // Returns value of off X axis of screen
    private function movedOffScreenX()
    {
        return x + width < FlxG.camera.scroll.x;
    }

    // If Enemy overlaps center of screen
    public static function overlapsWithCenter(center:FlxObject, enemy:Enemy)
    {
		enemy.kill();
    }
}