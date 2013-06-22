package
{

	public class Conf
	{
		// map world
		public static var levelSize:Array = [1000, 1000];

		// carpet world
		public static var carpetSize:Array = [8, 12];
		public static var carpetTileSize:Array = [40, 40];
		
		// Directions on carpet
		public static var up:int = 0;
		public static var left:int = 1;
		public static var down:int = 2;
		public static var right:int = 3;
		
		// Carpet related constants
		public static var thrusterForce:Number = 1;
		public static var carpetMass:Number = 1;
		public static var carpetMOI:Number = 1;
	}
}
