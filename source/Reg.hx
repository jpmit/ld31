package;

import flixel.FlxG;
import flixel.util.FlxSave;

class Reg
{
	// Width of the 'edges' (boundaries) of screen
	public static inline var EWIDTH:Int = 5;

	// Camera Zoom (cam 1 zoom should be 1.0)
	public static var CAM1ZOOM:Float = 1.0;
	public static var CAM2ZOOM:Float = 2.0;
	public static var CAM3ZOOM:Float = 4.0;

	public static var MUSICVOL:Float = 0.5;

	// Position of tutorial text
	public static var TUTX:Int = 150;
	public static var TUTY:Int = 20;

	private static var _numScreens:Map<Int, Int> =
		[1 => 1,
		 2 => 2,
		];

	public static function getNumScreens(lnum:Int)
	{
		if (_numScreens.exists(lnum))
		{
			return _numScreens[lnum];
		}
		return 3;
	}
	
	public static var levels:Array<Dynamic> = [];
	/**
	 * Generic level variable that can be used for cross-state stuff.
	 * Example usage: Storing the current level number.
	 */
	public static var level:Int = 0;
	/**
	 * Generic scores Array that can be used for cross-state stuff.
	 * Example usage: Storing the scores for level.
	 */
	public static var scores:Array<Dynamic> = [];
	/**
	 * Generic score variable that can be used for cross-state stuff.
	 * Example usage: Storing the current score.
	 */
	public static var score:Int = 0;
	/**
	 * Generic bucket for storing different FlxSaves.
	 * Especially useful for setting up multiple save slots.
	 */
	public static var saves:Array<FlxSave> = [];
}
