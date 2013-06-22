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
			var blocks:Object = {thruster: [], cannon: []}
// 			add(new CarpetEntity(blocks));
			var c:CarpetWorld = new CarpetWorld(blocks);
			carpets.push(c);
		}
		
	}

}
