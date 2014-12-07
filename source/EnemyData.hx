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
	public static var SPEED2 = 180;	

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
		 6 => [
			   [S1, P3, "1"]
		      ],
		 7 => [[S1, P4, "0.1"],
		       [S1, P5, "2.0"]
		      ],
	     // 8 and 9 should be hard levels
		 8 => [[S1, P5, "0.1"],
		       [S1, P1, "0.5" ],
		       [S2, P1, "1.4" ],
		       [S2, P1, "2.4" ],		 
		       [S2, P1, "3.4" ],
		       [S2, P1, "4.4" ],
		       [S2, P2, "4.5" ],
		       [S2, P1, "6.4" ],
		       [S2, P2, "6.5" ],
		       [S2, P3, "6.6" ],
		       [S2, P1, "8.4" ],
		       [S2, P2, "8.5" ],
		       [S2, P3, "8.6" ],
		       [S2, P4, "8.7" ],
		      ],

		 9 => [[S1, P5, "2"],
		       [S1, P4, "2.2"],
		       [S2, P2, "2.9"],
		       [S2, P2, "3.9"],
		       [S2, P2, "4.6"],
		       [S2, P1, "5.6"],
		       [S2, P2, "6.6"],
		       [S1, P1, "7.3"],
		       [S1, P2, "7.5"],
		       [S1, P3, "7.7"],		 		 		 
		      ],
		 
	     // 10 should introduce red (faster) enemies.
		 10 => [[S1, P5, "2.0", "y"],
		        [S1, P4, "2.0"]
		       ],
		 11 => [[S1, P5, "2.0", "y"],
		        [S1, P3, "2.4"],
		        [S2, P5, "4.0", "y"],
		        [S2, P3, "4.4"],
		        [S3, P4, "6.0", "y"],
		        [S3, P4, "8.4"],
		        [S2, P1, "10.0"],
		        [S2, P1, "13.0", "y"],		 
		       ],
		 12 => [[S1, P1, "1.0", "y"],
		 [S1, P1, "2.4", "y"],
		 [S1, P1, "2.6"],
		 [S1, P1, "3.3", "y"],
		 [S1, P1, "3.7"],
		 [S1, P3, "5.0"],
		 [S1, P4, "6.0"],
		 [S1, P4, "6.0", "y"],
		 ],
		 13 => [[S1, P1, "1.0", "y"],
		 [S1, P2, "1.1", "y"],
		 [S1, P1, "2.0", "y"],
		 [S1, P2, "2.1", "y"],
		 [S1, P3, "2.2", "y"],
		 [S1, P1, "3.0", "y"],
		 [S1, P2, "3.1", "y"],
		 [S1, P1, "3.0"],
		 // to bottom two screens
		 [S2, P1, "3.8", "y"],
		 [S2, P1, "4.5"],
		 [S3, P1, "5.3"],
		 [S3, P1, "6.9", "y"],
		 [S1, P1, "8.0", "y"],
		 [S1, P1, "8.5", "y"],
		 [S1, P1, "9.0", "y"],
		 [S1, P2, "9.1", "y"],
		 [S1, P3, "9.2", "y"],		 
		 ],
		 14 => [[S2, P3, "1.0", "y"],
		 [S2, P2, "1.5", "y"],
		 [S3, P4, "2.5", "y"],
		 [S3, P4, "3.5", "y"],
		 [S3, P4, "4.0", "y"],
		 [S3, P4, "5.0", "y"],
		 [S3, P1, "5.5"],
		 [S2, P1, "6.5"],
		 [S3, P4, "7.5"],
		 [S3, P1, "8.5"],
		 [S3, P4, "9.5"],
		 [S3, P1, "10.5"],		 
		 [S3, P4, "11.5"],
		 [S3, P1, "12.5"],
		 [S1, P1, "17", "y"]
		 ]
		 ];
}
