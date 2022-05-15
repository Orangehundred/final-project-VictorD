package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSubState;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.addons.ui.FlxButtonPlus;

class GameOverState extends FlxState
{
	var titleText:FlxText;
	var titleText2:FlxText;
	var endMessage:FlxText;
	var endMessage2:FlxText;
	var finalScore:FlxText;
	var totalScore:Int;

    public var uiGameOver:FlxTypedGroup<FlxText>;

	override public function create()
	{
		#if FLX_MOUSE
		FlxG.mouse.visible = true;
		#end

		// Final Score message
		totalScore = Hud.score;
		finalScore = new FlxText(0, 170, 0, "Final Score: " + totalScore, 22);
		finalScore.screenCenter(X);
		add(finalScore);

		// Game Over messages
        var gameOverText = new FlxText(0, 450, 0, "GAME OVER", 72);
        gameOverText.x = FlxG.width / 2 - gameOverText.width / 2;
        uiGameOver.add(gameOverText);
        
        var restartText = new FlxText(0, 550, 0, "Press 'R' to restart.", 12);
        restartText.x = FlxG.width / 2 - restartText.width / 2;
        uiGameOver.add(restartText);

		//FlxG.sound.play(AssetPaths.PlayerDeath__wav, 100); // Play player death sound

		super.create();
	}

    // Restart game function
	private function tryAgain()
	{
		FlxG.switchState(new PlayState());
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.justPressed)
		{
			//FlxG.sound.play(AssetPaths.MenuClick__wav, 100); // MenuClick sound
		}

        // If "R" is pressed, restart game
        if (FlxG.keys.justPressed.R)
        {
            tryAgain();            
        }
	}
}
