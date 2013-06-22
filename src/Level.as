package
{
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Sarah
	 */
	public class Level extends World
	{
		public var size:Array = Conf.levelSize;
		public var carpets:Array = [];
		
		public function Level()
		{
			var carpet:Object = { thruster : [], cannon : [] };
			var c:CarpetEntity = new CarpetEntity();
			carpets.push(c);
			add(c);
		}
		
	}

}
