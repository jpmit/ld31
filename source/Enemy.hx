package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Enemy extends CameraSprite
{
	private static var cIdMap:Map<String, Array<Int>> =
		[EnemyData.S1 => [1, 2, 3],
		 EnemyData.S2 => [1, 2],
	 	 EnemyData.S3 => [1, 2, 3]
		];
		
	public function new(x:Int, y:Int, speed:Int = 100, screens:String)
	{
		// Get the camera Ids we want
		super(x, y, cIdMap[screens]);

		if (screens == EnemyData.S1)
		{
			// All screens
			makeGraphic(8, 8, FlxColor.YELLOW);
		}
		else if (screens == EnemyData.S2)
		{
			// Screens 2 and 3 
			makeGraphic(4, 4, FlxColor.YELLOW);
		}
		else if (screens == EnemyData.S3)
		{
			// Screen 3 only
			makeGraphic(2, 2, FlxColor.YELLOW);
		}
				
		this.velocity.x = speed;
	}

	public override function update():Void
	{
		super.update();
	}
}
