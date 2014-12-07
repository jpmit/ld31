package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	private static inline var _gravity:Int = 200;

	private var _isJumping:Bool;
	private var _nJumpsMade:Int;
	private var _nJumpsAllowed:Int;

	public function new(x:Int, y:Int)
	{
		super(x, y);
		makeGraphic(20, 20, Reg.PCOL);
		maxVelocity.set(0, 100);

		// Will be set to false the first time we hit the floor
		_isJumping = true;
		_nJumpsMade = 0;

		if (Reg.canDoubleJump)
		{
			_nJumpsAllowed = 2;
		}
		else
		{
			_nJumpsAllowed = 1;
		}
	}

	public override function update():Void
	{
		acceleration.y = _gravity;

		if (this.isTouching(FlxObject.FLOOR))
		{
			_isJumping = false;
			_nJumpsMade = 0;
		}		

		if (velocity.y <= 0)
		{
			//this.isTouching(FlxObject.FLOOR))			
			if (FlxG.keys.justPressed.SPACE && _nJumpsMade < _nJumpsAllowed)
			{
				FlxG.sound.play("assets/sounds/jump.wav");
				this.velocity.y = -maxVelocity.y;
				_isJumping = true;
				++_nJumpsMade;
			}
		}
		
		super.update();
	}
}
