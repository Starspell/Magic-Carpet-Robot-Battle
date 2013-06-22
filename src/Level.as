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
		public var carpetWorld:CarpetWorld;
		
		public function Level()
		{
<<<<<<< HEAD
			carpetWorld = new CarpetWorld();
=======
			var blocks:Object = {thruster: [], cannon: []}
// 			add(new CarpetEntity(blocks));
			var c:CarpetWorld = new CarpetWorld(blocks);
			carpets.push(c);
>>>>>>> dc9080ae2a8175d49da4cc437a753510db0322d9
		}
		
		override public function update():void
		{
			carpetWorld.update();
			super.update();
		}
	}

}
