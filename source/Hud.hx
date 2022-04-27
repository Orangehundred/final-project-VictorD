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

	public function new(player_:Player, ?textSize:Int = 16, ?spriteSize:Int = 32)
	{
		super();

		player = player_;
		score = 0;
		player.health = 1;

		// Transparent black
		background = new FlxSprite(Std.int(FlxG.width * 0.25), FlxG.height * 0.001).makeGraphic(Std.int(FlxG.width / 2), Std.int(FlxG.height / 10), 0x55000000);

		var spriteHeight:Float = FlxG.height - background.height;
		// var textHeight:Float = (background.height - textSize) / 2;
		var textHeight:Float = FlxG.height - background.height;
		var textOffset:Float = spriteSize / 2;

		livesSprite = makeSprite(livesSprite, AssetPaths.heart__png, FlxG.width / 100, spriteHeight, spriteSize);
		livesCounter = new FlxText(livesSprite.x + livesSprite.width + textOffset, textHeight, 0, "" + player.health, textSize);
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
