package
{
	import net.flashpunk.World;
	import net.flashpunk.graphics;
	import Conf;
	
	/**
	 * ...
	 * @author Sarah
	 */
	public class Level extends World
	{
		public var size:Array = Conf.levelSize;
		public var player:Player;
		
		public function Level()
		{
			player = new Player(100, 100);
		}
		
	}

}
