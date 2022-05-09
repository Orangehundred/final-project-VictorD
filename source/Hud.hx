package;

import player.Player;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxTween;
import flixel.math.FlxPoint;

class Hud extends FlxTypedGroup<FlxSprite>
{
	var player:Player;
	var background:FlxSprite;
	var livesSprite:FlxSprite;
	var livesCounter:FlxText;
	var scoreLabel:FlxText;
	var scoreCounter:FlxText;

	public var uiInitialMenu:FlxTypedGroup<FlxText>;
	public var uiGameOver:FlxTypedGroup<FlxText>;

	public static var score:Int;

	public function new(player_:Player, ?textSize:Int = 20, ?spriteSize:Int = 32)
	{
		super();

		uiInitialMenu = new FlxTypedGroup<FlxText>();
		uiGameOver = new FlxTypedGroup<FlxText>();

		setUpInitialMenu(player);
		
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

		setUpGameOver();
	}

	// Main Menu Overlay
	public function setUpInitialMenu(player:Player):Void
	{
		var titleText = new FlxText(0, 25, 0, "BULLETHELL GAME", 48);
		titleText.x = FlxG.width / 2 - titleText.width / 2;
		uiInitialMenu.add(titleText);
		
		var byLine = new FlxText(0, 68, 0, "by Victor Duchscherer", 12);
		byLine.x = FlxG.width / 2 - byLine.width / 2;
		uiInitialMenu.add(byLine);
		
		
		var center = player.getMidpoint(); //WHY IS .getMidpoint INVALID FIELD ACCESS?
		
		var up  	= new FlxText(center.x, center.y - 92, "UP", 18);
		var down 	= new FlxText(center.x, center.y + 64, "DOWN", 18);
		var left	= new FlxText(center.x - 48, center.y, "LEFT", 18);
		var right	= new FlxText(center.x + 48, center.y, "RIGHT", 18);
		
		up.x	-= up.width / 2;
		down.x 	-= down.width / 2;
		left.x 	-= left.width;
		
		uiInitialMenu.add(up);
		uiInitialMenu.add(down);
		uiInitialMenu.add(left);
		uiInitialMenu.add(right);	
	}

	// Hide Main Menu Overlay when game starts
	public function hideInitialMenu():Void
		{
			var exitAnim = function(text:FlxText) 
			{
				var y = text.y;
				var kill = function(_){text.kill(); };
				FlxTween.tween(text, {alpha: 0, y: y - 4}, .3, {onComplete:kill}); 	
			};
			
			uiInitialMenu.forEach(exitAnim);
		}

	// Game Over menu
	public function setUpGameOver():Void
		{
			var gameOverText = new FlxText(0, 450, 0, "GAME OVER", 72);
			gameOverText.x = FlxG.width / 2 - gameOverText.width / 2;
			uiGameOver.add(gameOverText);
			
			var restartText = new FlxText(0, 550, 0, "Press 'R' to restart.", 12);
			restartText.x = FlxG.width / 2 - restartText.width / 2;
			uiGameOver.add(restartText);
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
