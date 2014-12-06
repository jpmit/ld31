package;

import flixel.FlxG;
import flixel.FlxSubState;

class PlayerDiedState extends FlxSubState
{
	private var _elapsed:Float;
	
	public function new()
	{
		FlxG.cameras.shake(0.005, 0.35);
		FlxG.cameras.flash(0xffDB3624, 0.35);
		_elapsed = 0;
		super();
	}

	override public function update():Void
	{
		_elapsed += FlxG.elapsed;

		super.update();

		if (_elapsed > 2)
		{
			close();
			FlxG.switchState(new PlayState());
		}
	}	
}
