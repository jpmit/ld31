package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	private static inline var _gravity:Int = 200;
	
	public function new(x:Int, y:Int)
	{
		super(x, y);
		makeGraphic(20, 20, FlxColor.BLACK);
		maxVelocity.set(0, 100);

		//immovable = true;
		//elasticity = 1.0;
	}

	public override function update():Void
	{
		acceleration.y = _gravity;

		if (this.isTouching(FlxObject.FLOOR))
		{
			if (FlxG.keys.justPressed.SPACE)
			{
				FlxG.sound.play("assets/sounds/jump.wav");
				this.velocity.y = - maxVelocity.y;
			}
		}
                
		super.update();
	}
}
