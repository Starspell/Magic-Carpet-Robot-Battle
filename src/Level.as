package
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
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
		
		public var worldBoundaryCoords:Array = [];
		
		public function Level(ident:int)
		{
			ident = ident;
			addGraphic(seaTiles);
			carpetWorlds = new Array();
			carpetEnts = new Array();
			carpetGraphics = new Array();
			var blocks:Object = { thruster: [[1, 1]], cannon: [[2, 3]] };
			nextCheckpoint = 0;

			addCarpet(blocks, 1, 30, 20);
			
			var boundaries:Array = [null, null, null, null];

			// add targets and gates
			var cpData:Array = Conf.levelData[ident].checkpoints;
			var i:int;
			for (i = 0; i < cpData.length; i++) {
				var args:Object = cpData[i][1];
				if (cpData[i][0] == "target") {
					add(new Target(args[0], args[1], i));
				} else { // cpData[i][0] == "gate"
					add(new Gate(args[0], args[1], args[2], args[3], this, i));
				}
				
				// World creation
				if ( boundaries[0] == null )
				{
					boundaries[0] = args[0];	// Smallest x
					boundaries[1] = args[0];	// Largest x
					boundaries[2] = args[1];	// Smallest y
					boundaries[3] = args[1];	// Largest y
				}
				else
				{
					if ( args[0] < boundaries[0] ) boundaries[0] = args[0];
					if ( args[0] > boundaries[1] ) boundaries[1] = args[0];
					if ( args[1] < boundaries[2] ) boundaries[2] = args[1];
					if ( args[1] < boundaries[3] ) boundaries[3] = args[1];
				}
			}
			
			worldBoundaryCoords[0] = new Point(boundaries[0] - Conf.boundarySpace, boundaries[2] - Conf.boundarySpace);
			worldBoundaryCoords[1] = new Point(boundaries[1] + Conf.boundarySpace, boundaries[3] + Conf.boundarySpace);
		}

		private function addCarpet(blocks:Object, nPlayers:int, x:int,
								   y:int):void {
			var cw:CarpetWorld = new CarpetWorld(blocks, nPlayers);
			carpetWorlds.push(cw);
			var e:Entity = addGraphic(new Image(cw.worldBuffer), -2, x, y);
			e.graphic.scrollX = e.graphic.scrollY = 0;
			carpetGraphics.push(e.graphic as Image);
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
				else if (cp is Gate) {}; //Gate code here!
				trace(nextCheckpoint);
				if (nextCheckpoint == Conf.levelData[ident].length) {
					trace("win");
				}
			}
		}
		
	}

}
