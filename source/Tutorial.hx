package;

import flixel.FlxG;
import flixel.FlxCamera;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;

class Tutorial
{
	private static var _tutData:Map<Int, Array<Array<String>>> =
		[1 => [["Press space to not die", "0.5", "2.5"]],
		2 => [["Apparently it's all one screen", "0.5", "2.5"]],
		3 => [["Not sure if I believe that though", "1.0", "3.0"]]
		];

	//private static var _tutX:Int = 150;
	//private static var _tutY:Int = 200;
	
	public static function setup(pstate:PlayState):Void
	{
		// Add any text
		if (_tutData.exists(pstate.levelNum))
		{
			// Most recent time at which text disappeared
			var lastTime:Float = 0;
			// Current lines of text
			var currentLines = 0;
			for (t in _tutData[pstate.levelNum])
			{
				// Number of lines of text for this dialogue
				var nlines = t.length - 2;
				var start = Std.parseFloat(t[nlines]);
				var end = Std.parseFloat(t[nlines + 1]);
				var txtArray = new Array();
				// Figure out if we are adding to existing dialogue
				if (start > lastTime)
				{
					currentLines = 0;
				}
					
				for (i in 0...nlines)
				{
					var txt = new FlxText(Reg.TUTX, Reg.TUTY + 30 * (i + currentLines), 400, t[i]);
					//txt.setFormat("assets/fonts/ShareTechMono-Regular.ttf", 22);
					txt.setFormat(null, 20, FlxColor.BLACK);
					//					txt.scrollFactor.set(0, 0);
					txtArray.push(txt);
				}
				currentLines += nlines;
				lastTime = end;
				new FlxTimer(start, function(timer:FlxTimer) { showText(pstate, txtArray); });
				new FlxTimer(end, function(timer:FlxTimer) { hideText(pstate, txtArray); });
			}
		}
	}

	public static function showText(pstate:PlayState, txtArray:Array<FlxText>)
	{
		FlxG.sound.play("assets/sounds/tut.wav");
		for (txt in txtArray)
		{
			pstate.add(txt);
		}
	}

	public static function hideText(pstate:PlayState, txtArray:Array<FlxText>)
	{
		for (txt in txtArray)
		{
			pstate.remove(txt);
		}
	}
}
