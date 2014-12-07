package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxMath;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.FlxG;
import flixel.util.FlxTimer;
using flixel.util.FlxSpriteUtil;

class MenuState extends FlxState
{
	private var _titleText:FlxText;
	private var _nTitleTweens:Int;
	private var _canStart:Bool;
	
	override public function create():Void
	{
		super.create();

		FlxG.mouse.visible = false;

		var block1 = new FlxSprite(0, 0);
		block1.makeGraphic(FlxG.width, Math.floor(FlxG.height / 3), FlxColor.WHITE);
		var block2 = new FlxSprite(0, 2 * FlxG.height / 3);
		block2.makeGraphic(FlxG.width, Math.floor(FlxG.height / 3), FlxColor.WHITE);

		add(block1);
		add(block2);
		
		_titleText = new FlxText(50, 0, 0, "3scale");
		_titleText.setFormat(null, 10, FlxColor.BLACK, "center");
		_titleText.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.WHITE, 2);

		// FlxTextFormat is color, bold, italic, BorderColor, Start, End
		_titleText.addFormat(new FlxTextFormat(Reg.OCOL, false, false, Reg.YCOL, 1, 6));

		_nTitleTweens = 0;
		_canStart = false;
		runTitleTextTween();

		add(_titleText);

		FlxG.sound.playMusic("assets/music/menu.wav", Reg.MUSICVOL, true);
		new FlxTimer(1.0, function(t:FlxTimer) { FlxG.sound.play("assets/sounds/whoosh.wav"); });
		new FlxTimer(1.2, addNameText);
	}

	public function addNameText(timer:FlxTimer)
	{
		var nameText = new FlxText(0, 0, 0, "A Ludum Dare 31 game by jpmit");
		nameText.setFormat(null, 20, Reg.BCOL, "center");
		nameText.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.BLACK, 2);
		
		FlxTween.tween(nameText, { x: 100, y: 300}, 1.0, {ease: FlxEase.elasticOut, complete:showStartText});
		add(nameText);
	}

	public function runTitleTextTween(?f:FlxTween):Void
	{
		if (_nTitleTweens > 0)
		{
			FlxG.sound.play("assets/sounds/tweenexpl.wav");
		}
		
		_nTitleTweens += 1;
		_titleText.size *= 2;
		_titleText.x = FlxG.width / 2 - _titleText.fieldWidth / 2;
		
		if (_nTitleTweens < 3)
		{
			FlxTween.tween(_titleText, { x: _titleText.x, y: _titleText.y + 90}, 0.5, {complete: runTitleTextTween});
		}
	}

	public function showStartText(f:FlxTween):Void
	{
		FlxG.sound.play("assets/sounds/tweenshort.wav");

		_canStart = true;
		var startText = new FlxText(200, 350, 0, "Press space to start");
		startText.setFormat(null, 20, FlxColor.BLACK, "center");
		startText.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.WHITE, 2);
		startText.x = FlxG.width / 2 - startText.fieldWidth / 2;		
		add(startText);
	}

	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		if (_canStart && FlxG.keys.justReleased.SPACE)
		{
			FlxG.sound.play("assets/sounds/start.wav");			
			new FlxTimer(1.0, function(t:FlxTimer) { FlxG.switchState(new PlayState()); });
		};
		super.update();
	}	
}
