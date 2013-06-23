package
{
	import net.flashpunk.utils.Key;

	public class Conf
	{
		// map world
		public static var levelSize:Array = [1000, 700];

		// carpet world
		public static var carpetSize:Array = [8, 12];
		public static var carpetTileSize:Array = [40, 40];
		
		// Directions on carpet
		public static var left:int = 0;
		public static var up:int = 1;
		public static var right:int = 2;
		public static var down:int = 3;
		
		// Carpet related constants
		public static var thrusterForce:Number = 0.1;
		public static var carpetMass:Number = 1;
		public static var carpetMOI:Number = 1000;
		public static var carpetFriction:Number = 0.1;
		public static var carpetRotFriction:Number = 5;
		
		// Player related constants
		public static var playerKeys:Array = [
			{
				move: [Key.LEFT, Key.UP, Key.RIGHT, Key.DOWN],
				grab: [Key.SPACE, Key.SHIFT]
			}
		];
		public static var tweenTime:Number = 10;
		public static var moveDelay:int = 4;
		
		public static function radiansToDegrees(rad:Number):Number
		{
			rad /= (2 * Math.PI);
			rad *= 360;
			return rad;
		}
		
		public static var bulletSpeed:Number = 2;
	}
}
