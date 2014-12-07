package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class GameCompleteState extends FlxState
{
	private var _comptxt:FlxText;
	private var _thtxt:FlxText;
	private var _deathtxt:FlxText;
	private var _againtxt:FlxText;
	private var _elapsed:Float;
	
	override public function create():Void
	{
		var background = new FlxSprite(0, 0);
		background.makeGraphic(FlxG.width, FlxG.height, Reg.CCOL);
		
		_comptxt = new FlxText(40, 0, 0, "Game Complete!");
		_comptxt.setFormat(null, 50, Reg.ENCOL, "center");
		_comptxt.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.BLACK, 2);

		//FlxG.sound.play("assets/sounds/whoosh.wav");
		FlxTween.tween(_comptxt, {x : 50, y: 100}, 5, {ease: FlxEase.elasticOut});

		_deathtxt = new FlxText(10, 200, FlxG.width, "You died " + Reg.nDeaths + " times");
		_deathtxt.setFormat(null, 20, FlxColor.BLACK, "center");
		//_deathtxt.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.BLACK, 2);
		
		_elapsed = 0;

		FlxG.sound.play("assets/sounds/whoosh.wav");

		add(background);
		add(_comptxt);		
		add(_deathtxt);

		super.create();
	}

	override public function update():Void
	{
		super.update();

		_elapsed += FlxG.elapsed;
		if (_elapsed > 8.5)
		{
			FlxG.switchState(new MenuState());
		}
	}
}
