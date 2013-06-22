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
			carpetWorld = new CarpetWorld();
		}
		
		override public function update():void
		{
			carpetWorld.update();
			super.update();
		}
	}

}
