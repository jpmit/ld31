package;

import flixel.FlxG;
import flixel.FlxSubState;

class LevelCompleteState extends FlxSubState
{
	private var _elapsed:Float;
	// The level number we just completed
	private var _ldone:Int;
	
	public function new(pstate:PlayState)
	{
		//		FlxG.cameras.shake(0.005, 0.35);
		//FlxG.cameras.flash(0xffDB3624, 0.35);
		FlxG.sound.play("assets/sounds/complete2.wav");
		_elapsed = 0;
		_ldone = pstate.levelNum;
		super();
	}

	override public function update():Void
	{
		_elapsed += FlxG.elapsed;

		super.update();
		if (_elapsed > 1)
		{
			if (_ldone == Reg.nLevels)
			{
				FlxG.switchState(new GameCompleteState());
			}
			else
			{
				FlxG.switchState(new PlayState(_ldone + 1));
			}
			close();
		}
	}
}
