package
{
	import net.flashpunk.graphics.TiledImage;
	import net.flashpunk.World;

	public class CarpetWorld extends World
	{
		[Embed(source = '../assets/sprites/sea.png')] private const SEA:Class;
		
		private var blocks:Object;
		private var seaTiles:TiledImage = new TiledImage(SEA, Conf.levelSize[0], Conf.levelSize[1]);
		public var player:Player;

		public function CarpetWorld(blocks:Object)
		{
			this.blocks = blocks;
			var bClasses:Array = [Thruster, Cannon];
			var bNames:Array = ["thruster", "cannon"];
			for (var i:int = 0; i < bClasses.length; i++) {
				var bList:Array = blocks[bNames[i]];
				for (var j:int = 0; j < bList.length; j++) {
					bList[j] = new bClasses[i](this, bList[j][0], bList[j][1]);
				}
			}
			player = new Player(this, 0, 0);
			add(player);
			add(new CarpetWorldBG());
			addGraphic(seaTiles, 0, 0, 0);
		}

		public function tileTL(x:int, y:int):Array {
			return [Conf.carpetTileSize[0] * x, Conf.carpetTileSize[1] * y];
		}
	}
}
