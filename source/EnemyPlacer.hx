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

	// If the level has been running for longer than this time, it is finished (been completed).
	private var _finishTime:Float;


	public function new(pstate:PlayState):Void
	{
		super();

		// Reference to current playstate
		_p = pstate;

		// Time elapsed
		_elapsed = 0.0;

		addEnemiesForLevel(pstate.levelNum);
	}

	private function addEnemiesForLevel(lnum:Int)
	{
		// y spawn points
		// 8 pixels is the base size of the enemies		
		var yLow:Int = _p.wHeight - Reg.WWIDTH - 8;
		var yMid:Int = yLow - 8;
		var yHigh:Int = yMid - 8;
		var yVeryHigh:Int = yHigh - 8;
		var yVeryVeryHigh:Int = yVeryHigh - 8;		
		
		_enemies = new FlxTypedGroup<Enemy>();
		add(_enemies);

		// Initialiser will determine finish time if no enemy data.
		var tSpawn:Float = 0.0;

		// Add the actual enemy spawning
		if (EnemyData.data.exists(lnum))
		{
			for (e in EnemyData.data[lnum])
			{
				var posY:Int;
				tSpawn = Std.parseFloat(e[2]);
				var screen = e[0];

				switch(e[1]) {
					// nearest the bottom of the screen
					case EnemyData.P1:
						posY = yLow;
					case EnemyData.P2:
						posY = yMid;
					case EnemyData.P3:
						posY = yHigh;
					case EnemyData.P4:
						posY = yVeryHigh;
					case EnemyData.P5:
						posY = yVeryVeryHigh;
					default:
						posY = yLow;
				}

				// X, Y, velocity, screens
				var emy = new Enemy(10, posY, EnemyData.SPEED1, screen);
				new FlxTimer(tSpawn, function(timer:FlxTimer) { _enemies.add(emy); });
			}
		}
		// Set finish time of level to be spawn time of final enemy plus time it
		// takes to traverse the level.
		_finishTime = tSpawn + (FlxG.width / EnemyData.SPEED1);
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
		return (_elapsed > _finishTime);
	}
}
