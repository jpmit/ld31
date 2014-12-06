package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Enemy extends CameraSprite
{
	public function new(x:Int, y:Int, speed:Int = 100, ?cIds:Array<Int>)
	{
		super(x, y, cIds);
		
		makeGraphic(5, 5, FlxColor.YELLOW);
		this.velocity.x = speed;
	}

	public override function update():Void
	{
		super.update();
	}
}
