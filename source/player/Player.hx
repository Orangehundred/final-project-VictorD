package player;

import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	public static var SPEED(default, never):Int = 200;

	public var maxHealth:Int = 1;


	public function new(X:Float = 0, Y:Float = 0)
	{
		super(X, Y);
		// makeGraphic(16, 16, FlxColor.RED);
		loadGraphic(AssetPaths.player__png, false);
		this.width = 50;
		this.height = 50;
		this.offset.x = 0;
		this.offset.y = 0;
		health = maxHealth;
	}

	override public function update(elapsed:Float)
	{
		setSpeed();
		super.update(elapsed);
	}

	private function setSpeed()
	{
		if (FlxG.keys.justPressed.UP)
		{
			velocity.y = -SPEED;
		}

		if (FlxG.keys.pressed.DOWN)
		{
			velocity.y = SPEED;
		}

		if (x < 4 || x > FlxG.width - width)
		{
			velocity.x = 0;
		}

		//NO IDEA WHY I CAN'T IMPLEMENT TOP AND BOTTOM BARRIERS IN HERE

		if (FlxG.keys.pressed.LEFT && x > FlxG.width - FlxG.width)
		{
			velocity.x = -SPEED;
		}

		if (FlxG.keys.pressed.RIGHT && x < FlxG.width - width)
		{
			velocity.x = SPEED;
		}

		if (FlxG.keys.pressed.RIGHT && FlxG.keys.pressed.LEFT)
		{
			// Cancel out
			velocity.x = 0;
		}

		if (FlxG.keys.pressed.UP && FlxG.keys.pressed.DOWN)
		{
			// Cancel out
			velocity.y = 0;
		}

		if (FlxG.keys.justReleased.LEFT || FlxG.keys.justReleased.RIGHT)
		{
			velocity.x = 0;
		}

		if (FlxG.keys.justReleased.UP || FlxG.keys.justReleased.DOWN)
		{
			velocity.y = 0;
		}
	}

	override function hurt(damage)
	{
		health -= 1;
	}
}
