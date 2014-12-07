package;

import flixel.FlxG;
import flixel.FlxSubState;

class LevelCompleteState extends FlxSubState
{
	private var _elapsed:Float;
	// The level number we just completed
	private var _ldone:Int;
	
	public function new(ldone:Int)
	{
		//		FlxG.cameras.shake(0.005, 0.35);
		//FlxG.cameras.flash(0xffDB3624, 0.35);
		//FlxG.sound.play("assets/sounds/complete.wav");
		_elapsed = 0;
		_ldone = ldone;
		super();
	}

	override public function update():Void
	{
		_elapsed += FlxG.elapsed;

		super.update();
		if (_elapsed > 1)
		{
			close();
			FlxG.switchState(new PlayState(_ldone + 1));
		}
	}
}
