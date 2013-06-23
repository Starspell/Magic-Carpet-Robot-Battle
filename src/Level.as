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
		public var nextCheckpoint:int;
		public var ident:int;
		
		public function Level(ident:int)
		{
			ident = ident;
			addGraphic(seaTiles);
			carpetWorlds = new Array();
			carpetEnts = new Array();
			carpetGraphics = new Array();
			var blocks:Object = { thruster: [[1, 1]], cannon: [[2, 3]] };
			nextCheckpoint = 0;
			
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

			var data:Object = Conf.levelData[ident];
			var linePts:Array = [[], []];
			var pts:Array = data.startPts;
			
			var hw:int = add(new Buoy(pts[0][0], pts[0][1])).halfWidth;
			var hh:int = add(new Buoy(pts[1][0], pts[1][1])).halfHeight;
			linePts[0].push([pts[0][0] + hw, pts[0][1] + hh]);
			linePts[1].push([pts[1][0] + hw, pts[1][1] + hh]);
			// add targets and gates
			var cpData:Array = data.checkpoints;
			var i:int;
			for (i = 0; i < cpData.length; i++) {
				var args:Object = cpData[i][1];
				if (cpData[i][0] == "target") {
					add(new Target(args[0], args[1], i));
				} else { // cpData[i][0] == "gate"
					add(new Gate(args[0], args[1], args[2], args[3], this, i));
					linePts[0].push([args[0] + hw, args[1] + hh]);
					linePts[1].push([args[2] + hw, args[3] + hh]);
				}
			}

			add(new Explosion(500, 500, 0, 60));
			pts = data.endPts;
			add(new Buoy(pts[0][0], pts[0][1]));
			add(new Buoy(pts[1][0], pts[1][1]));
			linePts[0].push([pts[0][0] + hw, pts[0][1] + hh]);
			linePts[1].push([pts[1][0] + hw, pts[1][1] + hh]);
			add(new GuideLines(linePts));
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
		public function checkpointPassed(cp:Checkpoint): void
		{
			if (cp.num == nextCheckpoint)
			{
				//Target is destroyed
				nextCheckpoint++;
				if (cp is Target) remove(cp);
				else if (cp is Gate) false; //Gate code here!
				trace(nextCheckpoint);
				if (nextCheckpoint == Conf.levelData[ident].length) {
					trace("win");
				}
			}
		}
		
	}

}
