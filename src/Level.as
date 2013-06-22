package
{
	import net.flashpunk.World;
	import net.flashpunk.graphics.TiledImage;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Sarah
	 */
	public class Level extends World
	{
		[Embed(source = '../assets/sprites/sea.png')] private const SEA:Class;
		
		public var size:Array = Conf.levelSize;
		public var carpetWorld:CarpetWorld;
		public var carpetGraphic:Image;
		private var seaTiles:TiledImage = new TiledImage(SEA, Conf.levelSize[0], Conf.levelSize[1]);
		public var carpetEnt:CarpetEntity;
		
		public function Level()
		{
			var blocks:Object = {thruster: [], cannon: []}
			carpetWorld = new CarpetWorld(blocks);
			carpetGraphic = (addGraphic(new Image(carpetWorld.worldBuffer), -2).graphic as Image);
			carpetEnt = new CarpetEntity(blocks);
			var t:Thruster = new Thruster(carpetWorld, 1, 1);
			t.dir = Conf.down;
			carpetWorld.add(t);
			add(carpetEnt);
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
			return super.updateLists();
		}
		
		override public function render():void
		{
			carpetWorld.render();
			carpetGraphic.updateBuffer();
			return super.render();
		}
	}

}
