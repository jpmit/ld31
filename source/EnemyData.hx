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
	public static var P4 = "4";
	public static var P5 = "5";		

	// Enemy speeds
	public static var SPEED1 = 120;

	// Each enemy has screen, spawn position, spawn time
	public static var data:Map<Int, Array<Array<String>>> =
		[
		 // Learn to jump
		 1 => [[S1, P1, "2"]
			  ],
		 // Learn to duck
		 2 => [[S1, P5, "2"]
		      ],
		 // Learn about 2 screens
		 3 => [[S1, P1, "2"]
		      ],
		 // Learn that some projectiles can be on some screens only
		 4 => [[S1, P1, "0.1"],
		       [S2, P1, "4.5"]
		      ],
		 // See all 3 screens for the first time
		 5 => [[S1, P1, "0.1"],
		       [S2, P1, "4.5"],
		       [S3, P1, "6.5"]
		      ],
		// Introduce double jump here
		 6 => [[S1, P1, "0.1"],
		       [S1, P2, "2.0"],
		       [S1, P3, "3.0"]
		      ],
		 7 => [[S1, P4, "0.1"],
		       [S1, P5, "1.0"]
		      ]
		 ];
}
