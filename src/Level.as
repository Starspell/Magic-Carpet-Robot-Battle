package
{
	import net.flashpunk.World;
	import net.flashpunk.graphics.TiledImage;
	
	/**
	 * ...
	 * @author Sarah
	 */
	public class Level extends World
	{
		[Embed(source = '../assets/sprites/sea.png')] private const SEA:Class;
		
		public var size:Array = Conf.levelSize;
		public var carpetWorld:CarpetWorld;
		private var seaTiles:TiledImage = new TiledImage(SEA, Conf.levelSize[0], Conf.levelSize[1]);
		
		public function Level()
		{
			var blocks:Object = {thruster: [[0,0]], cannon: []}
// 			add(new CarpetEntity(blocks));
			carpetWorld = new CarpetWorld(blocks);
			addGraphic(seaTiles, 0, 0, 0);
		}
		
		override public function update():void
		{
			carpetWorld.update();
			super.update();
		}
		
		override public function updateLists():void
		{
			carpetWorld.updateLists();
			super.updateLists();
		}
		
		override public function render():void
		{
			carpetWorld.render();
			super.render();
		}
	}

}
