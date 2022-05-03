package;

import enemies.Enemy;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.FlxObject;
import flixel.addons.display.FlxBackdrop;
import player.Player;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;


class PlayState extends FlxState
{
	// Background
	var backdrop:FlxBackdrop;

	// Top & Bottom Walls
	var bottomWall:FlxObject;
	var topWall:FlxObject;

	// Player
	var player:Player;
	
	// Hud
	var hud:Hud;

	// Centerpoint of screen
	var center:FlxObject;
	public var midpoint:FlxPoint;

	// Enemies
	var enemyGroup:FlxTypedGroup<Enemy>;
	var spawnTimer:Float = 0;

	override public function create()
	{

		// Call super
		super.create();

		// Create backdrop
		backdrop = new FlxBackdrop(AssetPaths.backdrop__png, 0, 1, false, true, 0, 0);
		backdrop.velocity.set(0, 100);

		// Create Center object
		var center = new FlxObject(FlxG.width / 2 - 75, FlxG.height / 2 - 75, 75, 75);
		midpoint = new FlxPoint(FlxG.width / 2, FlxG.height / 2);

		// Create Walls
		bottomWall = new FlxObject(0, FlxG.height, FlxG.width, (FlxG.height));
		bottomWall.immovable = true;
		topWall = new FlxObject(0, FlxG.height - FlxG.height, FlxG.width, (FlxG.height - FlxG.height));
		topWall.immovable = true;


		// Create player
		player = new Player(FlxG.width / 2, FlxG.height / 2);

		// Create HUD
		hud = new Hud(player, 22, 22);

		// Add elements
		add(backdrop);
		add(center);
		add(bottomWall);
		add(topWall);
		add(player);

		// Add in Enemies
		add(enemyGroup = new FlxTypedGroup<Enemy>(20));

		add(hud);
	}

	override public function update(elapsed:Float)
	{
		//SpawnTimer of enemies
		spawnTimer += elapsed * 5;
		if (spawnTimer > 1)
		{
			spawnTimer--;
			enemyGroup.add(enemyGroup.recycle(Enemy.new));
		}
		
		// Math for moving towards
		//if (FlxMath.inBounds(center.x, 0, FlxG.width)
		//	&& FlxMath.inBounds(center.y, 0, FlxG.height))
		//{
		//	if (FlxMath.isDistanceWithin(center, 10))
		//	{
		//		target.velocity.set();
		//	}
		//	else
		//		FlxVelocity.moveTowardsObject(center, 100);

		//	if (FlxMath.isDistanceWithin(enemy, center, 10))
		//	{
		//		enemy.velocity.set();
		//	}
		//	else
		//		FlxVelocity.moveTowardsObject(enemy, center, 20);
		//}
		//else
		//	center.velocity.set();

		super.update(elapsed);
		
		// Wall collision
		if (FlxG.collide(player, bottomWall))
		{
			player.velocity.y = 0;
		}
		
		if (FlxG.collide(player, topWall))
		{
			player.velocity.y = 0;
		}

		//Center colliding with enemy
		//FlxG.overlap(center, enemyGroup, Enemy.overlapsWithCenter);

		//ENEMIES COLLIDE WITH PLAYER AS WELL??

		// Press ENTER to fullscreen game window
		if (FlxG.keys.justPressed.ENTER)
			FlxG.fullscreen = !FlxG.fullscreen;
	}
}
