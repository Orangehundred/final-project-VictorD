package player;

import flixel.FlxG;
import flixel.FlxSprite;

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
		stopIfGoingOffScreen();

		super.update(elapsed);
	}

	private function setSpeed()
	{
		var verticalDirection = 0;
		verticalDirection += FlxG.keys.pressed.UP ? -1 : 0;
		verticalDirection += FlxG.keys.pressed.DOWN ? 1 : 0;
	
		var horizontalDirection = 0;
		horizontalDirection += FlxG.keys.pressed.LEFT ? -1 : 0;
		horizontalDirection += FlxG.keys.pressed.RIGHT ? 1 : 0;

		velocity.set(SPEED * horizontalDirection, SPEED * verticalDirection);
	}

	private function stopIfGoingOffScreen() 
	{
		var isGoingOffScreenLeft = FlxG.keys.pressed.LEFT && x < 0;
		var isGoingOffScreenRight = FlxG.keys.pressed.RIGHT && x > FlxG.width - width;
		if (isGoingOffScreenLeft || isGoingOffScreenRight) {
			velocity.x = 0;
		}
		
		var isGoingOffScreenTop = FlxG.keys.pressed.UP && y < 0;
		var isGoingOffScreenBottom = FlxG.keys.pressed.DOWN && y > FlxG.height - height;
		if (isGoingOffScreenTop || isGoingOffScreenBottom) {
			velocity.y = 0;
		}
	}

	override function hurt(damage)
	{
		health -= 1;
	}

	//ADD DODGE FUNCTION?
}
