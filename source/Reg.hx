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
	// Fast enemy color
	public static inline var FASTENCOL = 0xFF8F0000;
    // Color to highlight cameras on which we died
	public static inline var CDEATHCOL = 0xFFFFD700;
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

	// Total number of levels in the game
	public static inline var nLevels = 14;

	// Number of times the player has died
	public static var nDeaths = 0;

	// Mapping of level numbers to number of screens shown - if key doesn't
	// exist, 3 screens are shown.
	private static var _numScreens:Map<Int, Int> =
		[1 => 1,
		 2 => 1,
		 3 => 2,
		 4 => 2
		];

	// Max time elapsed in each level, used so that we don't display tutorial
	// text multiple times
	public static var tElapsed:Map<Int, Float> =
		[1 => 0.0,
		 2 => 0.0,
		 3 => 0.0,		
		 4 => 0.0,
		 5 => 0.0,		
		 6 => 0.0,
		 7 => 0.0,		
		 8 => 0.0,
		 9 => 0.0,		
		10 => 0.0,
		11 => 0.0,		
		12 => 0.0,
		13 => 0.0,		
		14 => 0.0,
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
	    // Default soundtrack
	    #if flash
	    return "assets/music/song2.mp3";
	    #else
	    return "assets/music/song2.ogg";
	    #end
	}

	public static function getNumScreens(lnum:Int)
	{
		if (_numScreens.exists(lnum))
		{
			return _numScreens[lnum];
		}
		return 3;
	}

	public static var canDoubleJump:Bool = false;
	
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
