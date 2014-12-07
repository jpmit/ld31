package;

// The enemies 
class EnemyData
{
	// Constants for enemy on screen 1 only, screens 1 and 2, screens 1, 2, 3
	public static var S1 = "1";
	public static var S2 = "2";
	public static var S3 = "3";

	// Constants for spawn position
	public static var P1 = "1";
	public static var P2 = "2";
	public static var P3 = "3";

	// Enemy speeds
	public static var SPEED1 = 120;

	// Each enemy has screen, spawn position, spawn time
	public static var data:Map<Int, Array<Array<String>>> =
		[1 => [[S1, P1, "0.1"],
			  ],
		 2 => [[S1, P1, "0.1"]],
		 3 => [[S1, P1, "0.1"],
		       [S2, P1, "4.5"]]
		];
}
