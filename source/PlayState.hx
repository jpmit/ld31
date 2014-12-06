package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxCamera;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import flixel.group.FlxTypedGroup;

class PlayState extends FlxState
{
	// Width and height of each world
	private var _wHeight:Int;
	private var _wWidth:Int;	
	private var _cam1:FlxCamera;
	private var _cam2:FlxCamera;
	private var _cam3:FlxCamera;
	// Cam 1 zoom is always 1.0
	private static var _cam1Zoom:Float = 1.0;
	private static var _cam2Zoom:Float = 2.0;
	private static var _cam3Zoom:Float = 4.0;
	private var _player:Player;
	private var _floor:FlxSprite;
	// Enemies
	private var _enemies:FlxTypedGroup<Enemy>;
	
	override public function create():Void
	{
		_wHeight = Math.floor(FlxG.height / 3);
		_wWidth = FlxG.width;
		FlxG.worldBounds.set(_wWidth, _wHeight);

		_floor = new FlxSprite(0, _wHeight - 20);
		_floor.immovable = true;
		_floor.makeGraphic(_wWidth, 20, FlxColor.BLUE);
		add(_floor);
		
		FlxG.mouse.visible = false;

		_player = new Player(300, 100);
		add(_player);

		// Cameras
		_cam1 = new FlxCamera(0, 0, _wWidth, _wHeight);
		_cam1.zoom = 1;
		_cam2 = new FlxCamera(0, _wHeight, _wWidth, _wHeight);
		_cam3 = new FlxCamera(0, _wHeight * 2,  _wWidth, _wHeight);
		_cam1.bgColor = FlxColor.WHITE;
		_cam2.bgColor = FlxColor.WHITE;
		_cam3.bgColor = FlxColor.WHITE;
		var pPoint = new FlxPoint(_player.x, _player.y);
		//_cam3.focusOn(pPoint);

		// Set camera positions.  Might also want to set bounds of cameras at
		// some point (try resizing neko window for example why)
		_cam1.zoom = _cam1Zoom;
		_cam2.zoom = _cam2Zoom;
		_cam2.scroll.x = 0.5 * (_wWidth - _wWidth /  _cam2Zoom);
		_cam2.scroll.y = _wHeight - _wHeight / _cam2Zoom;
		_cam3.zoom = _cam3Zoom;
		_cam3.scroll.x = 0.5 * (_wWidth - _wWidth /  _cam3Zoom);
		_cam3.scroll.y = _wHeight - _wHeight / _cam3Zoom;
		// Might not need this (at the moment it solves this screen resizing
		// issue).
		//_cam2.setBounds(_cam2.scroll.x, _cam2.scroll.y,
		//                _cam2.scroll.x + _wWidth / _cam2Zoom,
		//                _cam2.scroll.y + _wHeight / _cam2Zoom);
		//_cam3.setBounds(_cam3.scroll.x, _cam3.scroll.y,
		//                _cam3.scroll.x + _wWidth / _cam3Zoom,
		//                _cam3.scroll.y + _wHeight / _cam3Zoom);
		FlxG.cameras.add(_cam1);
		FlxG.cameras.add(_cam2);
		FlxG.cameras.add(_cam3);

		
		_enemies = new FlxTypedGroup<Enemy>();
		_enemies.add(new Enemy(0, 170));
		_enemies.add(new Enemy(0, 160, [1]));		
		add(_enemies);

		trace(_cam1.ID);
		trace(_cam2.ID);
		trace(_cam3.ID);		
		
		super.create();
	}

	override public function destroy():Void
	{
		super.destroy();
	}

	private function hitPlayer(obj1:FlxObject, obj2:FlxObject):Void
	{
		// Some cool animations here
		obj1.destroy();
	}

	override public function update():Void
	{
		FlxG.collide(_floor, _player);
		// Same as FlxG.collide but calls callback instead of FlxG.separate
		FlxG.overlap(_enemies, _player, hitPlayer);
		super.update();
	}
}
