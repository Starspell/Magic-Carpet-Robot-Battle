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
			var blocks:Object = {thruster: [[0,0]], cannon: []}
// 			add(new CarpetEntity(blocks));
			carpetWorld = new CarpetWorld(blocks);
		}
		
		override public function update():void
		{
			carpetWorld.update();
			super.update();
		}
	}

}
