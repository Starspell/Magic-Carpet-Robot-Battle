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
		private var grid:Array;
		public var worldBuffer:BitmapData;

		public function CarpetWorld(blocks:Object, nPlayers:int = 1)
		{
			super();
			
			worldBuffer = new BitmapData(
				Conf.carpetSize[0] * Conf.carpetTileSize[0],
				Conf.carpetSize[1] * Conf.carpetTileSize[1], false, 0
			);
			
			addGraphic(new Image(CARPET), 1, 0, 0);
			
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
					grid[bList[j][0]][bList[j][1]] = b;
					bList[j] = b;
					add(b);
				}
			}
			// put player in an empty tile
			var remain:int = nPlayers;
			var pID:int = 0;
			for (i = 0; i < Conf.carpetSize[0]; i++) {
				for (j = 0; j < Conf.carpetSize[1]; j++) {
					if (grid[i][j] === null) {
						add(new Player(this, i, j, pID));
						pID++;
						remain -= 1;
						if (remain == 0) break;
					}
				}
				if (remain == 0) break;
			}
			if (remain) trace("couldn't place all players...");
		}
		
		override public function add(e:Entity):Entity
		{
			e.renderTarget = worldBuffer;
			return super.add(e);
		}

		public function tileTL(x:int, y:int):Array{
			// get the top-left corner of an x, y tile on the drawn image
			return [Conf.carpetTileSize[0] * x, Conf.carpetTileSize[1] * y];
		}

		public function isFree(x:int, y:int):Boolean {
			// check if an x, y tile is empty
			return grid[x][y] === null;
		}

		public function tileInDir(pos:Array, dir:int):Array {
			// get the [x, y] tile in direction dir from position pos
			var dp:Array = [0, 0];
			dp[dir % 2] = (dir >= 2) ? 1 : -1;
			return [pos[0] + dp[0], pos[1] + dp[1]];
		}

		public function blockInTile(pos:Array):Block {
			// get the block in the given [x, y] tile, or null
			return grid[pos[0]][pos[1]];
		}

		public function blockInDir(pos:Array, dir:int):Block {
			// get the block one tile in direction dir from position pos, or
			// null
			pos = tileInDir(pos, dir);
			return grid[pos[0]][pos[1]];
		}

		public function moveTo(e:Block, x:int, y:int, cb:Function):void {
			// move a block to the x, y tile position, calling cb when the move
			// is complete
			grid[e.pos[0]][e.pos[1]] = null;
			grid[x][y] = e;
			e.pos = [x, y];
			// animation
			FP.tween(e, {
					x: x * Conf.carpetTileSize[0],
					y: y * Conf.carpetTileSize[1]
				}, Conf.tweenTime, {
					tweener: FP.tweener, complete: cb
				}
			);
		}

		public function setPos(e:Block, x:int, y:int):void {
			// set a block's x, y tile position without animation
			grid[e.pos[0]][e.pos[1]] = null;
			grid[x][y] = e;
			e.pos = [x, y];
			e.x = Conf.carpetTileSize[0] * x;
			e.y = Conf.carpetTileSize[1] * y;
		}
	}
}
