package;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;

class EnemyPlacer extends FlxGroup
{
	private var _enemies:FlxTypedGroup<Enemy>;

	// Store references to player and boundaries to assist with collisions
	private var _p:PlayState;

	public function new(p:PlayState):Void
	{
		super();

		// Reference to current playstate
		_p = p;

		_enemies = new FlxTypedGroup<Enemy>();
		_enemies.add(new Enemy(0, 170));
		
		// appear on camera 1 only
		_enemies.add(new Enemy(0, 160, [1]));		
		add(_enemies);
	}

	override public function update():Void
	{
		// Same as FlxG.collide but calls callback instead of FlxG.separate
		FlxG.overlap(_enemies, _p.player, _p.hitPlayer);
		FlxG.overlap(_enemies, _p.boundaries, _p.hitPlayer);		

		super.update();
	}
}
