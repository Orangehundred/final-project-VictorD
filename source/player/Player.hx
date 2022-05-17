package player;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import flixel.addons.effects.FlxTrail;

class Player extends FlxSprite
{
	public var SPEED:Int = 200;
	public var maxHealth:Int = 1;
	public var damage:Int;



	// Dash variables
	public var dashValue:Int = 100;
	public var dashCooldown:FlxTimer = new FlxTimer();
	public var speedChange:FlxTimer = new FlxTimer();
	public var trailOffTimer:FlxTimer = new FlxTimer();
	public var canDash:Bool = true;
	public var isDashing:Bool;
	public var trail:FlxTrail;

	public function new(X:Float = 0, Y:Float = 0)
	{
		super(X, Y);
		// makeGraphic(16, 16, FlxColor.RED);
		loadGraphic(AssetPaths.player__png, false);
		this.width = 50;
		this.height = 50;
		this.offset.x = 0;
		this.offset.y = 0;
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

	private function resetSPEED(timer:FlxTimer)
		{
			// Toggle isDashing
			isDashing = false;
			// Reset speed
			SPEED = 200;
		}
	
	private function boostSPEED()
		{
			// Toggle isDashing
			isDashing = true;
			// Change speed
			SPEED = SPEED * 5;
			// Start timer 0.08
			speedChange.start(0.08, resetSPEED, 1);
		}
	
		public function trailOn()
		{
			trail.revive();
			trail.resetTrail();
		}
	
		private function trailOff(timer:FlxTimer)
		{
			trail.kill();
		}
	
		private function resetDash(timer:FlxTimer)
		{
			canDash = true;
			dashValue = 1;
		}
	
		public function isDashReady():Bool
		{
			return canDash;
		}
	
		private function dash()
		{
			if (canDash && FlxG.keys.pressed.X)
			{
				// Call boostSPEED
				boostSPEED();
				// Start trail
				trailOn();
				// Turn trail off timer
				trailOffTimer.start(0.08, trailOff, 1);
				// Toggle canDash
				canDash = false;
				// Set bar value
				dashValue = 0;
				// Reset dashCooldown
				dashCooldown.start(1.75, resetDash, 1);
			}
		}
}


