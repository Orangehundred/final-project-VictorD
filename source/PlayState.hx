package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.group.FlxGroup;

import player.Player;



class PlayState extends FlxState
{


	// Player
	var player:Player;

	override public function create()
	{

		// call super
		super.create();

		// create player
		player = new Player(FlxG.width / 2, FlxG.height - 80);

		// add elements
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
