package
{
	import net.flashpunk.World;
	import net.flashpunk.Entity;

	public class CarpetWorld extends World
	{
		private var blocks:Object;
		public var player:Player;
		private var grid:Array;

		public function CarpetWorld(blocks:Object)
		{
			grid = new Array();
			var i:int, j:int;
			for (i = 0; i < Conf.carpetSize[0]; i++) {
				grid.push(new Array());
				for (j = 0; j < Conf.carpetSize[1]; j++) {
					grid[i].push(null);
				}
			}
			this.blocks = blocks;
			var bClasses:Array = [Thruster, Cannon];
			var bNames:Array = ["thruster", "cannon"];
			for (i = 0; i < bClasses.length; i++) {
				var bList:Array = blocks[bNames[i]];
				for (j = 0; j < bList.length; j++) {
					bList[j] = new bClasses[i](this, bList[j][0], bList[j][1]);
					add(bList[j]);
				}
			}
			// put player in an empty tile
			var done:Boolean = false;
			for (i = 0; i < Conf.carpetSize[0]; i++) {
				for (j = 0; j < Conf.carpetSize[1]; j++) {
					if (grid[i][j] === null) {
						player = new Player(this, i, j);
						add(player);
						done = true;
						break;
					}
				}
				if (done) break;
			}
			if (!done) trace("couldn't place player...");
			add(new CarpetWorldBG());
		}

		public function tileTL(x:int, y:int):Array {
			return [Conf.carpetTileSize[0] * x, Conf.carpetTileSize[1] * y];
		}

		public function setPos(e:Entity, x:int, y:int):void {
			grid[x][y] = e;
			(e as Block).pos = [x, y];
			e.x = Conf.carpetTileSize[0] * x;
			e.y = Conf.carpetTileSize[1] * y;
		}
	}
}
