package
{
	import net.flashpunk.utils.Key;

	public class Conf
	{
		public static const screenSize:Array = [1000, 700];
		
		// map world
		public static const carpetPos:Array = [[30, 20]];
		public static const levelData:Array = [
			// level 1
			{
				// positions to start the lines at
				startPts: [[400, 80], [700, 120]],
				// right positions to end the lines at
				endPts: [[600, 600], [850, 630]],
				// list of [type, data]
				// for target: data is position
				// for gate: data is [startx, starty, endx, endy]
				checkpoints: [
					["target", [500, 400]],
					["gate", [600, 300, 800, 250]],
					["gate", [600, 400, 850, 500]]
				],
				carpets: [{
					// list of [x, y] tile position
					thrusters: [[2, 2], [4, 2]],
					// list of [x, y] tile position
					cannons: [[4, 4], [5, 9]]
				}]
			}
		];
		public static const boundarySpace:int = 500;
		public static const seaMovementSpeed:Number = 0.25;

		// carpet world
		public static const carpetSize:Array = [8, 12];
		public static const carpetTileSize:Array = [40, 40];
		
		// Directions on carpet
		public static const left:int = 0;
		public static const up:int = 1;
		public static const right:int = 2;
		public static const down:int = 3;
		
		// Carpet related constants
		public static const thrusterForce:Number = 0.1;
		public static const carpetMass:Number = 1;
		public static const carpetMOI:Number = 1000;
		public static const carpetFriction:Number = 0.1;
		public static const carpetRotFriction:Number = 5;
		public static const cannonFireInterval:int = 60;
		// Carpet bouncing consts:
		public static const buoyRepel:Number = 3; //Buoy repulsion factor on bounce.
		public static const edgeRepel:Number = 3; //Edge of world repulsion factor on bounce.
		
		public static const gateCollideDist:Number = 15;

		
		// Other Entity Constants
		
		// Player related constants
		// list of [tint, keys] for each player
		public static const playerData:Array = [
			[0xffffff, {
				move: [Key.LEFT, Key.UP, Key.RIGHT, Key.DOWN],
				grab: [Key.SHIFT]
			}], [0xff9900, {
				move: [Key.A, [Key.W, 188], [Key.D, Key.E], [Key.S, Key.O]],
				grab: [Key.SPACE]
			}]
		];
		public static const tweenTime:Number = 10;
		public static const moveDelay:int = 4;
		
		public static function radiansToDegrees(rad:Number):Number
		{
			rad %= (2 * Math.PI);
			rad /= (2 * Math.PI);
			rad *= 360;
			return rad;
		}
		
		public static const bulletSpeed:Number = 4;
	}
}
