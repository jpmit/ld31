package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxCamera;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;

class PlayState extends FlxState
{
	public var player:Player;
	public var boundaries:FlxGroup;

	// Level number (first level is 1)
	public var levelNum:Int;
	
	// Width and height of each world (i.e. the 'screen')
	public var wHeight:Int;
	public var wWidth:Int;

	public var tElapsed:Float;

	// Cameras numbered from top
	private var _cam1:FlxCamera;
	private var _cam2:FlxCamera;
	private var _cam3:FlxCamera;

	// EnemyPlacer adds and removes enemies
	private var _eplacer:EnemyPlacer;

	// Text that notes how many times I died
	private var _deathText:FlxText;

	override public function new(lnum:Int = 1):Void
	{
		levelNum = lnum;
		super();
	}
	
	override public function create():Void
	{
		FlxG.mouse.visible = false;
		
		// Set world dimensions (same as top screen in pixels)
		wHeight = Math.floor(FlxG.height / 3);
		wWidth = FlxG.width;
		FlxG.worldBounds.set(wWidth, wHeight);

		// Store time elapsed
		tElapsed = 0.0;

		// Create screen boundary
		var _floor = new FlxSprite(0, wHeight - Reg.WWIDTH);
		_floor.immovable = true;
		_floor.makeGraphic(wWidth, Reg.WWIDTH, Reg.WCOL);
		var _ceiling = new FlxSprite(0, 0);
		_ceiling.immovable = true;
		_ceiling.makeGraphic(wWidth, Reg.WWIDTH, Reg.WCOL);
		var _lwall = new FlxSprite(0, 0);
		_lwall.immovable = true;
		_lwall.makeGraphic(Reg.WWIDTH, wHeight, Reg.WCOL);
		var _rwall = new FlxSprite(wWidth - Reg.WWIDTH, 0);
		_rwall.immovable = true;
		_rwall.makeGraphic(Reg.WWIDTH, wHeight, Reg.WCOL);
		boundaries = new FlxGroup();
		boundaries.add(_floor);
		boundaries.add(_ceiling);
		boundaries.add(_lwall);
		boundaries.add(_rwall);		
		add(boundaries);

		// Allow double jump after level 6
		if (levelNum >= 6)
		{
			Reg.canDoubleJump = true;
		}

		player = new Player(300, 100);
		add(player);

		// Cameras
		_cam1 = new FlxCamera(0, 0, wWidth, wHeight);
		_cam2 = new FlxCamera(0, wHeight, wWidth, wHeight);
		_cam3 = new FlxCamera(0, wHeight * 2,  wWidth, wHeight);
		_cam1.bgColor = Reg.CCOL;
		_cam2.bgColor = Reg.CCOL;
		_cam3.bgColor = Reg.CCOL;

		// Set camera positions, extents, and zoom.
		_cam1.zoom = Reg.CAM1ZOOM;
		_cam1.scroll.x = 0.5 * (wWidth - wWidth /  Reg.CAM1ZOOM);
		_cam1.scroll.y = wHeight - wHeight / Reg.CAM1ZOOM;
		_cam1.width = Math.floor(FlxG.width / Reg.CAM1ZOOM);
		//_cam1.height = Math.floor((FlxG.height / 3) / Reg.CAM1ZOOM);
		_cam2.zoom = Reg.CAM2ZOOM;
		_cam2.scroll.x = 0.5 * (wWidth - wWidth /  Reg.CAM2ZOOM);
		_cam2.scroll.y = wHeight - wHeight / Reg.CAM2ZOOM;
		_cam2.width = Math.floor(FlxG.width / Reg.CAM2ZOOM);
		_cam2.height = Math.floor((FlxG.height / 3) / Reg.CAM2ZOOM);		
		_cam3.zoom = Reg.CAM3ZOOM;
		_cam3.scroll.x = 0.5 * (wWidth - wWidth /  Reg.CAM3ZOOM);
		_cam3.scroll.y = wHeight - wHeight / Reg.CAM3ZOOM;
		_cam3.width = Math.floor(FlxG.width / Reg.CAM3ZOOM);
		_cam3.height = Math.floor((FlxG.height /  3) / Reg.CAM3ZOOM);
		//_cam2.setBounds(_cam2.scroll.x, _cam2.scroll.y,
		//                _cam2.scroll.x + wWidth / _cam2Zoom,
		//                _cam2.scroll.y + wHeight / _cam2Zoom);
		//_cam3.setBounds(_cam3.scroll.x, _cam3.scroll.y,
		//                _cam3.scroll.x + wWidth / _cam3Zoom,
		//                _cam3.scroll.y + wHeight / _cam3Zoom);
		FlxG.cameras.add(_cam1);
		FlxG.cameras.add(_cam2);
		FlxG.cameras.add(_cam3);

		// Setup tutorial
		Tutorial.setup(this);

		// Level text
		var ltxt = new FlxText(590, Reg.TUTY, 100, "L" + levelNum);
		ltxt.setFormat(null, 20, FlxColor.BLACK);
		add(ltxt);

		// Death text
		_deathText = new FlxText(590, Reg.TUTY + 20, 100, "D");// "D" + Reg.nDeaths);
		updateDeathText();
		add(_deathText);

		// Draw an additional camera (offscreen) over _cam2 and _cam3 if
		// disabled!
		var nScreens = Reg.getNumScreens(levelNum);
		if (nScreens != 3)
		{
			var obscureCamera = new FlxCamera(0, 0, wWidth, wHeight * 2);
			// Make it the same color as the walls
			obscureCamera.bgColor = Reg.WCOL;
			// Only top screen enabled
			if (nScreens == 1)
			{
				obscureCamera.y = wHeight;
			}
			else if (nScreens == 2)
			{
				obscureCamera.y = wHeight * 2;				
			}
			FlxG.cameras.add(obscureCamera);
			// Place camera 'offscreen' so no sprites are drawn
			obscureCamera.scroll.y = FlxG.height;	
		}

		// Enemies
		_eplacer = new EnemyPlacer(this);
		add(_eplacer);

		// Don't loop the main music, start new music on certain levels only
		var changeMusicLevels:Array<Int> = [1, 2, 6];
		if (Lambda.has(changeMusicLevels, levelNum))
		{
			var loop:Bool;
			if (levelNum == 1)
			{
				loop = false;
			}
			else
			{
				loop = true;
			}
			FlxG.sound.playMusic(Reg.getMusic(levelNum), Reg.MUSICVOL, loop);
		}

		
		super.create();
	}

	override public function destroy():Void
	{
		super.destroy();
	}

	public function hitPlayer(obj1:FlxObject, obj2:FlxObject):Void
	{
		// Some cool animations here (could use a substate if necessary)
		updateDeathText();
		this.subState = new PlayerDiedState(this);
		obj1.destroy();
	}

	public function updateDeathText():Void
	{
		_deathText.text = "D" + Reg.nDeaths;
		_deathText.setFormat(null, 20, FlxColor.BLACK);
		_deathText.updateFrameData();
	}

	override public function update():Void
	{
		// Make sure I hit the floor
		FlxG.collide(boundaries, player);

		if (_eplacer.enemiesDone())
		{
			this.subState = new LevelCompleteState(this);
		}

		// Update max time elapsed in this level (used so we don't redisplay
		// tutorial text)
		tElapsed += FlxG.elapsed;

		super.update();
	}
}
