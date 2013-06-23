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
		private var seaTiles:TiledImage = new TiledImage(SEA, Conf.levelSize[0], Conf.levelSize[1]);
		public var carpetWorlds:Array;
		public var carpetGraphics:Array;
		public var carpetEnts:Array;
		
		public function Level()
		{
			addGraphic(seaTiles);
			carpetWorlds = new Array();
			carpetEnts = new Array();
			carpetGraphics = new Array();
			var blocks:Object = { thruster: [[1, 1]], cannon: [[2, 3]] };
			
			// All the thrusters!
			/*var t:Array = [];
            for (var i:int = 1; i <= 6; ++i)
            {
                for (var j:int = 1; j <= 10; ++j)
                {
                    t.push([i, j]);
                }
            }
            var blocks:Object = { thruster: t, cannon: [] }*/

			addCarpet(blocks, 1, 30, 20);
		}

		private function addCarpet(blocks:Object, nPlayers:int, x:int,
								   y:int):void {
			var cw:CarpetWorld = new CarpetWorld(blocks, nPlayers);
			carpetWorlds.push(cw);
			carpetGraphics.push(
				addGraphic(new Image(cw.worldBuffer), -2, x, y).graphic
				as Image
			);
			var ce:CarpetEntity = new CarpetEntity(blocks);
			carpetEnts.push(ce);
			add(ce);
		}
		
		override public function update():void
		{
			for each (var c:CarpetWorld in carpetWorlds) c.update();
			super.update();
		}
		
		override public function updateLists():void
		{
			for each (var c:CarpetWorld in carpetWorlds) c.updateLists();
			return super.updateLists();
		}
		
		override public function render():void
		{
			for (var i:int; i < carpetWorlds.length; i++) {
				carpetWorlds[i].render();
				carpetGraphics[i].updateBuffer();
			}
			return super.render();
		}
	}

}
