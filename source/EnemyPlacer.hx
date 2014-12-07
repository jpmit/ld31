package;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxTimer;

class EnemyPlacer extends FlxGroup
{
	private var _enemies:FlxTypedGroup<Enemy>;

	// Store references to player and boundaries to assist with collisions
	private var _p:PlayState;
	private var _elapsed:Float;

	// y spawn points
	private var _yLow:Int;
	private var _yMid:Int;
	private var _yHigh:Int;	

	public function new(pstate:PlayState):Void
	{
		super();

		// Reference to current playstate
		_p = pstate;

		// Time elapsed
		_elapsed = 0.0;

		_enemies = new FlxTypedGroup<Enemy>();
		
		// appear on camera 2 and 3 only
		//_enemies.add(new Enemy(0, 130, 100, [2, 3]));		
		add(_enemies);

		// 8 pixels is the base size of the enemies
		_yLow = pstate.wHeight - Reg.WWIDTH - 8;
		_yMid = _yLow - 8;
		_yHigh = _yMid - 8;

		// Add the actual enemy spawning
		if (EnemyData.data.exists(pstate.levelNum))
		{
			for (e in EnemyData.data[pstate.levelNum])
			{
				var posY:Int;
				var tSpawn = Std.parseFloat(e[2]);

				// X, Y, velocity, screens
				var emy = new Enemy(10, _yLow, 100, e[1]);
				new FlxTimer(tSpawn, function(timer:FlxTimer) { _enemies.add(emy); });
			}
		}
		
	}

	override public function update():Void
	{
		_elapsed += FlxG.elapsed;
		// Same as FlxG.collide but calls callback instead of FlxG.separate
		FlxG.overlap(_enemies, _p.player, _p.hitPlayer);
		//FlxG.overlap(_enemies, _p.boundaries, _p.hitPlayer);
		super.update();
	}

	public function enemiesDone():Bool
	{
		if (_elapsed > 5)
		{
			return true;
		}
		return false;
	}
}
