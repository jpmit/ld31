package;

import flixel.FlxG;
import flixel.util.FlxSave;

class Reg
{
	// Blue color
	public static inline var BCOL = 0x6283FF;
	// Orange
	public static inline var OCOL = 0xFF8000;
	// Yellow
	public static inline var YCOL = 0xE6E600;
	// Player color (needs alpha setting as the first byte)
	public static inline var PCOL = 0xFF000052;
	// Camera background color
	public static inline var CCOL = 0xFFFFF177;
	// Enemy color
	public static inline var ENCOL = 0xFFFF8000;
	// Wall color
	public static inline var WCOL = 0xFF5F6478;
	// Width of the 'walls'
	public static inline var WWIDTH:Int = 5;

	// Camera Zoom (cam 1 zoom should be 1.0)
	public static var CAM1ZOOM:Float = 1.0;
	public static var CAM2ZOOM:Float = 2.0;
	public static var CAM3ZOOM:Float = 4.0;

	public static var MUSICVOL:Float = 2.0;

	// Position of tutorial text
	public static var TUTX:Int = 150;
	public static var TUTY:Int = 20;

	// Mapping of level numbers to number of screens shown - if key doesn't
	// exist, 3 screens are shown.
	private static var _numScreens:Map<Int, Int> =
		[1 => 1,
		 2 => 2,
		 3 => 2
		];

	// Music for each level
	private static var _music:Map<Int, String> =
		[1 => "song1short",
		 2 => "song1"
		];

	public static function getMusic(lnum:Int)
	{
		if (_music.exists(lnum))
		{
	       var mstr = "assets/music/" + _music[lnum];
	       #if flash
		   return mstr + ".mp3";
	       #else
		   return mstr + ".ogg";
	       #end
		}
	    return "assets/music/song2.wav";
	}

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
