package
{
	import net.flashpunk.FP;
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
		public var carpets:Array;
		public var carpetGraphics:Array;
		private var seaTiles:TiledImage = new TiledImage(SEA, Conf.levelSize[0], Conf.levelSize[1]);
		public var carpetEnt:CarpetEntity;
		
		public function Level()
		{
			var blocks:Object = {thruster: [], cannon: []}
			carpets = new Array();
			carpets.push(new CarpetWorld(blocks));
			carpetEnt = new CarpetEntity(blocks);
			add(carpetEnt);
			addGraphic(seaTiles, 0, 0, 0);
			// add CarpetWorld buffers as graphics
			carpetGraphics = new Array();
			for (var i:int = 0; i < carpets.length; i++) {
				var c:CarpetWorld = carpets[i];
				carpetGraphics.push(
					addGraphic(
						new Image(c.worldBuffer), -2,
						i * (FP.width - c.worldBuffer.width)
					).graphic as Image
				);
			}
		}
		
		override public function update():void
		{
			for each (var c:CarpetWorld in carpets) c.update();
			super.update();
		}
		
		override public function updateLists():void
		{
			for each (var c:CarpetWorld in carpets) c.updateLists();
			return super.updateLists();
		}
		
		override public function render():void
		{
			for (var i:int; i < carpets.length; i++) {
				carpets[i].render();
				carpetGraphics[i].updateBuffer();
			}
			return super.render();
		}
	}

}
