package;

import flixel.FlxGame;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();

		addChild(new FlxGame(1000, 1000, PlayState));
	}
}
