import flixel.FlxG;
import flixel.FlxSprite;

// A class for drawing sprites on selected cameras only.  This is achieved
// simply by turning 'off' the unwanted cameras, calling the FlxSprite draw
// routines, then turning on the unwanted cameras again.

class CameraSprite extends FlxSprite
{
	private var _camId:Int;
	private var _camIds:Array<Int>;

	public function new(x:Int, y:Int, ?cIds:Array<Int>)
	{
		// If cIds is null, we'll draw the sprite on all cameras
		_camIds = cIds;
		super(x, y);
	}
	
	public override function draw():Void
	{
		if (_camIds != null)
		{
			for (i in _camIds)
			{
				FlxG.cameras.list[i].exists = false;
			}
		}

		super.draw();

		if (_camIds != null)
		{
			for (i in _camIds)
			{
				FlxG.cameras.list[i].exists = true;
			}
		}
	}
}
