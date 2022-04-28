package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.group.FlxGroup;
import flixel.FlxObject;
import flixel.addons.display.FlxBackdrop;

import player.Player;



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

	override public function create()
	{

		// Call super
		super.create();

		// Create backdrop
		backdrop = new FlxBackdrop(AssetPaths.backdrop__png, 0, 1, false, true, 0, 0);
		backdrop.velocity.set(0, 100);

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
		add(bottomWall);
		add(topWall);
		add(player);
		add(hud);
	}

	// SpawnTimer of enemies, deals with just NORMY type enemies at the moment.
	override public function update(elapsed:Float)
	{
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

		// Press ENTER to fullscreen game window
		if (FlxG.keys.justPressed.ENTER)
			FlxG.fullscreen = !FlxG.fullscreen;
	}
}
