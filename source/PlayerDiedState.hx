package;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;

class PlayerDiedState extends FlxSubState
{
	private var _lnum:Int;
	private var _elapsed:Float;

	private var _playerGibs:FlxEmitter;
	private var _enemyGibs:FlxEmitter;

	private var _playerPixel:FlxParticle;
	private var _enemyPixel:FlxParticle;	
	
	public function new(pstate:PlayState, player:Player, enemy:Enemy)
	{
		_lnum = pstate.levelNum;

		for (i in enemy.wantedCameras)
		{
			var cam = FlxG.cameras.list[i];
			cam.bgColor = Reg.CDEATHCOL;
			cam.flash(FlxColor.BLACK, 0.35);
			cam.shake(0.005, 0.35);
		}

		_playerGibs = new FlxEmitter();
		_enemyGibs = new FlxEmitter();
		pstate.add(_playerGibs);
		pstate.add(_enemyGibs);
		
		_playerGibs.setXSpeed(-200, 200);
		_playerGibs.setYSpeed(-200, 0);		
		_enemyGibs.setXSpeed(-200, 200);
		_enemyGibs.setYSpeed(-200, 0);
		// Make the actual particles
		for (i in 0...10)
		{
			_playerPixel = new FlxParticle();
			_playerPixel.makeGraphic(4, 4, Reg.PCOL);
			_playerPixel.visible = false;
			_playerGibs.add(_playerPixel);
			
			_enemyPixel = new FlxParticle();
			if (enemy.velocity.x == EnemyData.SPEED1)
			{
				_enemyPixel.makeGraphic(2, 2, Reg.ENCOL);
			}
			else
			{
				_enemyPixel.makeGraphic(2, 2, Reg.FASTENCOL);
			}
			_enemyPixel.visible = false;			
			_enemyGibs.add(_enemyPixel);
		}

		_playerGibs.at(player);
		_enemyGibs.at(enemy);
		_playerGibs.start();
		_enemyGibs.start();

		//
		player.destroy();
		enemy.destroy();		

		updateNumDeaths();

		// We keep track of the maximum time played for the level we died in
		if (pstate.tElapsed > Reg.tElapsed[pstate.levelNum])
		{
			Reg.tElapsed[pstate.levelNum] = pstate.tElapsed;
		}

		// Set max time elapsed in this state
		FlxG.sound.play("assets/sounds/death.wav");
		_elapsed = 0;
		super();
	}

	private function updateNumDeaths()
	{
		// Update global registry
		// Be nice and only allow 99 deaths max
		if (Reg.nDeaths <= 99)
		{			
			Reg.nDeaths += 1;
		}
	}

	override public function update():Void
	{
		_elapsed += FlxG.elapsed;

		super.update();

		if (_elapsed > 2)
		{
			close();
			FlxG.switchState(new PlayState(_lnum));
		}
	}	
}
