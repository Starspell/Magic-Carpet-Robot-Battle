package  
{
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Sarah
	 */
	public class Level extends World 
	{
		public var player:Player;
		
		public function Level() 
		{
			player = new Player(100, 100);
		}
		
	}

}