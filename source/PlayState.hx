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
import flixel.util.FlxColor;


class PlayState extends FlxState
{
	// Background
	var backdrop:FlxBackdrop;

	// Player
	var player:Player;
	
	// Hud
	var hud:Hud;

	// Gameover & GameStart variable
	var _gameStarted:Bool = false;
	var _gameOver:Bool = false;

	// Enemies
	var enemyGroup:FlxTypedGroup<Enemy>;
	var enemySpawnTimer:Float = 0;

	var centerEnemyGroup:FlxTypedGroup<CenterEnemy>;
	var centerEnemySpawnTimer:Float = 0;
	var centerEnemyCurrentAngle:Float = 0;
	var centerPoint:FlxPoint;

	var ringEnemyGroup:FlxTypedGroup<RingEnemy>;
	var ringEnemySpawnTimer:Float = 0;

	var gameTimer:Float = 0;

	override public function create()
	{
		// Hide Cursor
		FlxG.mouse.visible = false;

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
		add(enemyGroup = new FlxTypedGroup<Enemy>(30));
		add(centerEnemyGroup = new FlxTypedGroup<CenterEnemy>(60));
		add(ringEnemyGroup = new FlxTypedGroup<RingEnemy>(100));
		centerPoint = new FlxPoint(FlxG.width / 2, FlxG.height / 2);

		add(hud.uiInitialMenu);
		add(hud);
	}

	private function startGame()
		{
			hud.hideInitialMenu();
			_gameStarted = true;
		}
		
		public function gameOver()
		{
			FlxG.camera.flash(FlxColor.WHITE, .2);
			FlxG.camera.shake(0.01, 0.2);
			add(hud.uiGameOver);
			
			player.kill();
	
			_gameOver = true;
		}

	override public function update(elapsed:Float)
	{
		// SpawnTimer of enemies
		enemySpawnTimer += elapsed * 3;
		if (enemySpawnTimer > 1  && Hud.score >= 20)
		{
			enemySpawnTimer = 0; //Set to 0 so no overflow of enemies spawning all at once

			var newEnemy:Enemy = enemyGroup.recycle(Enemy.new);
			var spawnLocationX = FlxG.random.float(0, FlxG.width);
			var spawnLocationY = 0;
			newEnemy.reset(spawnLocationX, spawnLocationY);
			enemyGroup.add(newEnemy);
		}

		centerEnemySpawnTimer += elapsed * 2;
		if (centerEnemySpawnTimer > 1 && Hud.score >= 125)
		{
			centerEnemySpawnTimer = 0; //Set to 0 so no overflow of enemies spawning all at once

			var distanceFromMiddle:Float = 450;
			var movingPoint = new FlxPoint(centerPoint.x + distanceFromMiddle, centerPoint.y);
			// var randomAngle = FlxG.random.float(0, 360);
			movingPoint.rotate(centerPoint, centerEnemyCurrentAngle);
			centerEnemyCurrentAngle = (centerEnemyCurrentAngle + 10) % 360;

			var newCenterEnemy:CenterEnemy = centerEnemyGroup.recycle(CenterEnemy.new);
			newCenterEnemy.reset(movingPoint.x, movingPoint.y);
			centerEnemyGroup.add(newCenterEnemy);
		}

		ringEnemySpawnTimer += elapsed * 0.2;
		if (ringEnemySpawnTimer > 1 && Hud.score >= 5)
		{
			ringEnemySpawnTimer = 0;

			var distanceFromMiddle:Float = 500;
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
		FlxG.overlap(player, ringEnemyGroup, RingEnemy.overlapsWithPlayer);
		FlxG.overlap(player, centerEnemyGroup, CenterEnemy.overlapsWithPlayer);
		FlxG.overlap(player, enemyGroup, Enemy.overlapsWithPlayer);
		
		if (_gameStarted)
			{
			gameTimer += elapsed * 1;
				if (gameTimer > 1)
				{
					gameTimer--;
					hud.addScore(1);
				}
			}

		super.update(elapsed);

		if (!_gameStarted)
			{
				if (FlxG.keys.anyPressed([W, A, S, D, UP, DOWN, LEFT, RIGHT, SPACE]))
					startGame();
			}
			else if (_gameOver)
			{
				if (FlxG.keys.anyPressed([R]))
				{
					FlxG.resetState();
				}
		// Press ENTER to fullscreen game window
		if (FlxG.keys.justPressed.ENTER)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}

		// End the game if the player reaches 0 lives or health
		if (player.health <= 0)
			{
				//FlxG.sound.play(AssetPaths.PlayerDeath__wav, 100);
				_gameOver = true;
				player.kill();
				{
					//FlxG.switchState(new GameOverState());
				}
			}		

	
		}
	}
}