package
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.TiledImage;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;
	/**
	 * ...
	 * @author Sarah
	 */
	public class Level extends World
	{
		[Embed(source = '../assets/sprites/sea.png')] private const SEA:Class;

		private var seaTiles:TiledImage;
		public var carpetWorlds:Array;
		public var carpetGraphics:Array;
		public var carpetEnts:Array;
		public var nextCheckpoint:int;
		public var ident:int;
		public var worldBoundaryCoords:Array = [];
		
		public function Level(ident:int)
		{
			ident = ident;
			carpetWorlds = new Array();
			carpetEnts = new Array();
			carpetGraphics = new Array();
			nextCheckpoint = 0;
			
			var boundaries:Array = [null, null, null, null];

			var data:Object = Conf.levelData[ident];
			var linePts:Array = [[], []];
			var pts:Array = data.startPts;

			var blocks:Object = { thruster: [[1, 1]], cannon: [[2, 3]] };
			addCarpet(blocks, 1, 30, 20, .5 * (pts[0][0] + pts[1][0]),
					  .5 * (pts[0][1] + pts[1][1]));
			
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
				
				// World creation
				if ( boundaries[0] == null )
				{
					boundaries[0] = args[0]; // Smallest x
					boundaries[1] = args[0]; // Largest x
					boundaries[2] = args[1]; // Smallest y
					boundaries[3] = args[1]; // Largest y
				}
				else
				{
					if ( args[0] < boundaries[0] ) boundaries[0] = args[0];
					if ( args[0] > boundaries[1] ) boundaries[1] = args[0];
					if ( args[1] < boundaries[2] ) boundaries[2] = args[1];
					if ( args[1] < boundaries[3] ) boundaries[3] = args[1];
				}
			}

			pts = data.endPts;
			add(new Buoy(pts[0][0], pts[0][1]));
			add(new Buoy(pts[1][0], pts[1][1]));
			linePts[0].push([pts[0][0] + hw, pts[0][1] + hh]);
			linePts[1].push([pts[1][0] + hw, pts[1][1] + hh]);
			add(new GuideLines(linePts));

			worldBoundaryCoords[0] = new Point(boundaries[0] - Conf.boundarySpace, boundaries[2] - Conf.boundarySpace);
			worldBoundaryCoords[1] = new Point(boundaries[1] + Conf.boundarySpace, boundaries[3] + Conf.boundarySpace);

			seaTiles = new TiledImage(
				SEA, worldBoundaryCoords[1].x - worldBoundaryCoords[0].x,
				worldBoundaryCoords[1].y - worldBoundaryCoords[0].y
			);
			var seaTileEnt:Entity = addGraphic(seaTiles);
			seaTileEnt.layer = 1;
			seaTileEnt.x = worldBoundaryCoords[0].x;
			seaTileEnt.y = worldBoundaryCoords[0].y;
		}

		private function addCarpet(blocks:Object, nPlayers:int, wx:int, wy:int,
								   ex:int, ey:int):void {
			var cw:CarpetWorld = new CarpetWorld(blocks, nPlayers);
			carpetWorlds.push(cw);
			var e:Entity = addGraphic(new Image(cw.worldBuffer), -2, wx, wy);
			e.graphic.scrollX = e.graphic.scrollY = 0;
			carpetGraphics.push(e.graphic as Image);
			var ce:CarpetEntity = new CarpetEntity(blocks, ex, ey);
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
			
			super.render();
		}

		public function checkpointPassed(cp:Checkpoint):Boolean
		{
			if (cp.num == nextCheckpoint)
			{
				//Target is destroyed
				nextCheckpoint++;
				if (cp is Target) remove(cp);
				else if (cp is Gate) {}; //Gate code here!
				if (nextCheckpoint == Conf.levelData[ident].length) {
					trace("win");
				}
				return true;
			} else return false;
		}
		
	}

}
