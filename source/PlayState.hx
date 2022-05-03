package;

import enemies.RingEnemy;
import enemies.CenterEnemy;
import enemies.Enemy;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.FlxObject;
import flixel.addons.display.FlxBackdrop;
import player.Player;
import flixel.math.FlxPoint;


class PlayState extends FlxState
{
	// Background
	var backdrop:FlxBackdrop;

	// Player
	var player:Player;
	
	// Hud
	var hud:Hud;

	// Enemies
	var enemyGroup:FlxTypedGroup<Enemy>;
	var enemySpawnTimer:Float = 0;

	var centerEnemyGroup:FlxTypedGroup<CenterEnemy>;
	var centerEnemySpawnTimer:Float = 0;
	var centerEnemyCurrentAngle:Float = 0;
	var centerPoint:FlxPoint;

	var ringEnemyGroup:FlxTypedGroup<RingEnemy>;
	var ringEnemySpawnTimer:Float = 0;

	override public function create()
	{

		// Call super
		super.create();

		// Create backdrop
		backdrop = new FlxBackdrop(AssetPaths.backdrop__png, 0, 1, false, true, 0, 0);
		backdrop.velocity.set(0, 100);

		// Create player
		player = new Player(FlxG.width / 2, FlxG.height / 2);

		// Create HUD
		hud = new Hud(player, 22, 22);

		// Add elements
		add(backdrop);
		add(player);

		// Add in Enemies
		add(enemyGroup = new FlxTypedGroup<Enemy>(20));
		add(centerEnemyGroup = new FlxTypedGroup<CenterEnemy>(100));
		add(ringEnemyGroup = new FlxTypedGroup<RingEnemy>(200));
		centerPoint = new FlxPoint(FlxG.width / 2, FlxG.height / 2);

		add(hud);
	}

	override public function update(elapsed:Float)
	{
		// SpawnTimer of enemies
		enemySpawnTimer += elapsed * 5;
		if (enemySpawnTimer > 1)
		{
			enemySpawnTimer--;
			var newEnemy:Enemy = enemyGroup.recycle(Enemy.new);
			var spawnLocationX = FlxG.random.float(0, FlxG.width);
			var spawnLocationY = 0;
			newEnemy.reset(spawnLocationX, spawnLocationY);
			enemyGroup.add(newEnemy);
			
		}

		centerEnemySpawnTimer += elapsed * 8;
		if (centerEnemySpawnTimer > 1)
		{
			centerEnemySpawnTimer--;

			var distanceFromMiddle:Float = 400;
			var movingPoint = new FlxPoint(centerPoint.x + distanceFromMiddle, centerPoint.y);
			// var randomAngle = FlxG.random.float(0, 360);
			movingPoint.rotate(centerPoint, centerEnemyCurrentAngle);
			centerEnemyCurrentAngle = (centerEnemyCurrentAngle + 10) % 360;

			var newCenterEnemy:CenterEnemy = centerEnemyGroup.recycle(CenterEnemy.new);
			newCenterEnemy.reset(movingPoint.x, movingPoint.y);
			centerEnemyGroup.add(newCenterEnemy);
		}

		ringEnemySpawnTimer += elapsed;
		if (ringEnemySpawnTimer > 1)
		{
			ringEnemySpawnTimer--;

			var distanceFromMiddle:Float = 450;
			var movingPoint = new FlxPoint(centerPoint.x + distanceFromMiddle, centerPoint.y);
			var ringAngle = 30;
			for (i in 0...12) {
				movingPoint.rotate(centerPoint, ringAngle);
				
				var newRingEnemy:RingEnemy = ringEnemyGroup.recycle(RingEnemy.new);
				var spawnLocationX:Float = movingPoint.x - (newRingEnemy.width / 2);
				var spawnLocationY:Float = movingPoint.y - (newRingEnemy.height / 2);
				newRingEnemy.reset(spawnLocationX, spawnLocationY);
				ringEnemyGroup.add(newRingEnemy);
			}
			
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

		//Center colliding with enemy
		//FlxG.overlap(center, enemyGroup, Enemy.overlapsWithCenter);

		//ENEMIES COLLIDE WITH PLAYER AS WELL??

		// Press ENTER to fullscreen game window
		if (FlxG.keys.justPressed.ENTER)
			FlxG.fullscreen = !FlxG.fullscreen;
	}
}
