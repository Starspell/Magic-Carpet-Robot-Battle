package
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import flash.display.BitmapData;

	public class CarpetWorld extends World
	{		
		[Embed(source = '../assets/sprites/carpetarea.png')] private const CARPET:Class;
		
		private var blocks:Object;
		public var player:Player;
		private var grid:Array;
		public var worldBuffer:BitmapData;

		public function CarpetWorld(blocks:Object)
		{
			super();
			addGraphic(new Image(CARPET), -20, 0, 0);
			
			// initialise grid
			grid = new Array();
			var i:int, j:int;
			for (i = 0; i < Conf.carpetSize[0]; i++) {
				grid.push(new Array());
				for (j = 0; j < Conf.carpetSize[1]; j++) {
					grid[i].push(null);
				}
			}
			// create and add blocks
			this.blocks = blocks;
			var bClasses:Array = [Thruster, Cannon];
			var bNames:Array = ["thruster", "cannon"];
			for (i = 0; i < bClasses.length; i++) {
				var bList:Array = blocks[bNames[i]];
				for (j = 0; j < bList.length; j++) {
					var b:Block = new bClasses[i](this, bList[j][0],
												  bList[j][1]);
					bList[j] = b;
					grid[i][j] = b;
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
			
			worldBuffer = new BitmapData(
				Conf.carpetSize[0] * Conf.carpetTileSize[0],
				Conf.carpetSize[1] * Conf.carpetTileSize[1], false, 0
			);
		}
		public override function add(e:Entity):Entity {
			e.renderTarget = worldBuffer;
			trace(e);
			return super.add(e);
		}

		public function tileTL(x:int, y:int):Array {
			return [Conf.carpetTileSize[0] * x, Conf.carpetTileSize[1] * y];
		}

		public function setPos(e:Block, x:int, y:int):void {
			grid[e.pos[0]][e.pos[1]] = null;
			grid[x][y] = e;
			e.pos = [x, y];
			e.x = Conf.carpetTileSize[0] * x;
			e.y = Conf.carpetTileSize[1] * y;
		}
	}
}
