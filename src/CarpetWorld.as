package
{
	import net.flashpunk.World;

	public class CarpetWorld extends World
	{
		private var blocks:Object;
		public var player:Player;

		public function CarpetWorld(blocks:Object)
		{
			this.blocks = blocks;
			var bClasses:Array = [Thruster, Cannon];
			var bNames:Array = ["thruster", "cannon"];
			for (var i:int = 0; i < bClasses.length; i++) {
				var bList:Array = blocks[bNames[i]];
				for (var j:int = 0; j < bList.length; j++) {
					bList[j] = bClasses[i](this, bList[j][0], bList[j][1]);
				}
			}
			player = new Player(this, 0, 0);
			add(player);
		}

		public function tileTL(x:int, y:int):Array {
			return [Conf.carpetTileSize[0] * x, Conf.carpetTileSize[1] * y];
		}
	}
}
