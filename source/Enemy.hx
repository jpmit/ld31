package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Enemy extends CameraSprite
{
	// Mapping of enemy screens string to array of cameras on which we want to
	// show the enemy (1 is top, 2 is middle, 3 is bottom).
	private static var cIdMap:Map<String, Array<Int>> =
		[EnemyData.S1 => [1, 2, 3],
		 EnemyData.S2 => [2, 3],
	 	 EnemyData.S3 => [3]
		];
		
	public function new(x:Int, y:Int, speed:Int, screens:String)
	{
		// Get the camera Ids we want
		super(x, y, cIdMap[screens]);

		var col = Reg.ENCOL;
		if (speed == EnemyData.SPEED2)
		{
			col = Reg.FASTENCOL;
		}
		makeGraphic(8, 8, col);
				
		this.velocity.x = speed;
	}

	public override function update():Void
	{
		super.update();
	}
}
