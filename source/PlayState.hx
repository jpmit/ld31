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
	
	// Width and height of each world (i.e. the 'screen')
	private var _wHeight:Int;
	private var _wWidth:Int;	
	private var _cam1:FlxCamera;
	private var _cam2:FlxCamera;
	private var _cam3:FlxCamera;
	// Width of edges
	private static inline var _EWIDTH:Int = 20;
	// Cam 1 zoom is always 1.0
	private static var _cam1Zoom:Float = 1.0;
	private static var _cam2Zoom:Float = 2.0;
	private static var _cam3Zoom:Float = 4.0;
	// EnemyPlacer adds and removes enemies
	private var _eplacer:EnemyPlacer;
	
	override public function create():Void
	{
		// Set world dimensions (same as top screen in pixels)
		_wHeight = Math.floor(FlxG.height / 3);
		_wWidth = FlxG.width;
		FlxG.worldBounds.set(_wWidth, _wHeight);

		// Create screen boundary
		var _floor = new FlxSprite(0, _wHeight - _EWIDTH);
		_floor.immovable = true;
		_floor.makeGraphic(_wWidth, _EWIDTH, FlxColor.BLUE);
		var _ceiling = new FlxSprite(0, 0);
		_ceiling.immovable = true;
		_ceiling.makeGraphic(_wWidth, _EWIDTH, FlxColor.BLUE);
		var _lwall = new FlxSprite(0, 0);
		_lwall.immovable = true;
		_lwall.makeGraphic(_EWIDTH, _wHeight, FlxColor.BLUE);
		var _rwall = new FlxSprite(_wWidth - _EWIDTH, 0);
		_rwall.immovable = true;
		_rwall.makeGraphic(_EWIDTH, _wHeight, FlxColor.BLUE);
		boundaries = new FlxGroup();
		boundaries.add(_floor);
		boundaries.add(_ceiling);
		boundaries.add(_lwall);
		boundaries.add(_rwall);		
		add(boundaries);
		
		FlxG.mouse.visible = false;

		player = new Player(300, 100);
		add(player);

		// Cameras
		_cam1 = new FlxCamera(0, 0, _wWidth, _wHeight);
		_cam1.zoom = 1;
		_cam2 = new FlxCamera(0, _wHeight, _wWidth, _wHeight);
		_cam3 = new FlxCamera(0, _wHeight * 2,  _wWidth, _wHeight);
		_cam1.bgColor = FlxColor.WHITE;
		_cam2.bgColor = FlxColor.WHITE;
		_cam3.bgColor = FlxColor.WHITE;
		var pPoint = new FlxPoint(player.x, player.y);

		// Set camera positions and zoom.
		_cam1.zoom = _cam1Zoom;
		_cam2.zoom = _cam2Zoom;
		_cam2.scroll.x = 0.5 * (_wWidth - _wWidth /  _cam2Zoom);
		_cam2.scroll.y = _wHeight - _wHeight / _cam2Zoom;
		_cam3.zoom = _cam3Zoom;
		_cam3.scroll.x = 0.5 * (_wWidth - _wWidth /  _cam3Zoom);
		_cam3.scroll.y = _wHeight - _wHeight / _cam3Zoom;
		//_cam2.setBounds(_cam2.scroll.x, _cam2.scroll.y,
		//                _cam2.scroll.x + _wWidth / _cam2Zoom,
		//                _cam2.scroll.y + _wHeight / _cam2Zoom);
		//_cam3.setBounds(_cam3.scroll.x, _cam3.scroll.y,
		//                _cam3.scroll.x + _wWidth / _cam3Zoom,
		//                _cam3.scroll.y + _wHeight / _cam3Zoom);
		FlxG.cameras.add(_cam1);
		FlxG.cameras.add(_cam2);
		FlxG.cameras.add(_cam3);

		// Enemies
		_eplacer = new EnemyPlacer(this);
		add(_eplacer);
		
		super.create();
	}

	override public function destroy():Void
	{
		super.destroy();
	}

	public function hitPlayer(obj1:FlxObject, obj2:FlxObject):Void
	{
		// Some cool animations here (could use a substate if necessary)
		this.subState = new PlayerDiedState();
		obj1.destroy();
	}

	override public function update():Void
	{
		FlxG.collide(boundaries, player);

		super.update();
	}
}
