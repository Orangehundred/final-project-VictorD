package;

import player.Player;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.system.debug.Window;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class Hud extends FlxTypedGroup<FlxSprite>
{
	var player:Player;
	var background:FlxSprite;
	var livesSprite:FlxSprite;
	var livesCounter:FlxText;
	var scoreLabel:FlxText;
	var scoreCounter:FlxText;

	public static var score:Int;

	public function new(player_:Player, ?textSize:Int = 20, ?spriteSize:Int = 32)
	{
		super();

		player = player_;

		//HUD Text Values
		score = 0;
		player.health = 1;

		// Transparent black
		background = new FlxSprite(Std.int(FlxG.width / 2.5), 0).makeGraphic(Std.int(FlxG.width / 5), Std.int(FlxG.height * 0.05), 0x55000000);

		scoreLabel = new FlxText((FlxG.width / 2.5 + 45), FlxG.height * 0.01, "Score: ", textSize);
		scoreCounter = new FlxText(scoreLabel.x + scoreLabel.width, FlxG.height * 0.01, 0, "" + score, textSize);
		scoreCounter.scrollFactor.set(0, 0);

		add(background);
		add(scoreCounter);
		add(scoreLabel);
	}

	private function makeSprite(sprite:FlxSprite, assetPath:String, spriteX:Float, spriteHeight:Float, spriteSize:Int)
	{
		sprite = new FlxSprite(0, 0, assetPath);
		sprite.setGraphicSize(spriteSize, spriteSize);
		sprite.updateHitbox();
		sprite.setPosition(spriteX, spriteHeight);
		
		//Lock HUD to screen
		sprite.scrollFactor.set(0, 0);
		
		return sprite;
	}

	public function addScore(Score:Int)
	{
		score += Score;
		scoreCounter.text = "" + score;
	}

	public function removeScore()
	{
		score = 0;
		scoreCounter.text = "" + score;
	}
}
