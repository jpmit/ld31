package;

import flixel.FlxG;
import flixel.FlxSubState;

class PlayerDiedState extends FlxSubState
{
	private var _lnum:Int;
	private var _elapsed:Float;
	
	public function new(pstate:PlayState)
	{
		_lnum = pstate.levelNum;
		// Update global registry
		// Be nice and only allow 99 deaths max
		if (Reg.nDeaths <= 99)
		{			
			Reg.nDeaths += 1;
		}
		FlxG.cameras.shake(0.005, 0.35);
		FlxG.cameras.flash(0xffDB3624, 0.35);
		FlxG.sound.play("assets/sounds/death.wav");
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
			FlxG.switchState(new PlayState(_lnum ));
		}
	}	
}
