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
	//Background
	var backdrop:FlxBackdrop;

	// Wall
	var bottomWall:FlxObject;

	// Player
	var player:Player;	

	override public function create()
	{

		// call super
		super.create();

		// create backdrop
		backdrop = new FlxBackdrop(AssetPaths.backdrop__png, 0, 1, false, true, 0, 0);
		backdrop.velocity.set(0, 100);

		// create bottom wall
		bottomWall = new FlxObject(0, FlxG.height, FlxG.width, (FlxG.height - 10));
		bottomWall.immovable = true;

		// create player
		player = new Player(FlxG.width / 2, FlxG.height / 2);

		// add elements
		add(backdrop);
		add(bottomWall);
		add(player);

	}

	// SpawnTimer of enemies, deals with just NORMY type enemies at the moment.
	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// Bottom wall collision
		if (FlxG.collide(player, bottomWall))
		{
			player.velocity.y = 0;
		}

		if (FlxG.keys.justPressed.ENTER)
			FlxG.fullscreen = !FlxG.fullscreen;
	}
}
