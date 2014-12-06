import flixel.FlxG;
import flixel.FlxSprite;

// A class for drawing sprites on selected cameras only.  This is achieved
// simply by turning 'off' the unwanted cameras, calling the FlxSprite draw
// routines, then turning on the unwanted cameras again.

class CameraSprite extends FlxSprite
{
	// Array of camera ids we do *not* want to draw this sprite on.
	private var _camIds:Array<Int>;

	// cIds is an array of camera IDs (the flixel ID of the camera object) that
	// should draw the object.
	public function new(x:Int, y:Int, ?cIds:Array<Int>)
	{
		// Build the array of camera ids that we do *not* want to draw this
		// sprite on.  If cIds is null, we'll draw the sprite on all cameras.
		if (cIds != null)
		{
			_camIds = new Array<Int>();
			for (i in 0...FlxG.cameras.list.length)
			{
				if (!Lambda.has(cIds, i))
				{
					_camIds.push(i);
				}
			}
		}

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
