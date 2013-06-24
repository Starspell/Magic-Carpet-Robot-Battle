package
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Draw;
	
	/**
	 * ...
	 * @author Sarah
	 */
	public class Gate extends Checkpoint
	{
		[Embed(source = '../assets/sprites/gateCone.png')] private const IMG:Class;
		
		public var endGate:Entity;
		
		public var midX:Number;
		public var midY:Number;
		
		private var endX:int;
		private var endY:int;
		
		public var norm:Point;
		public var tang:Point;
		
		public var halfLength:Number;
		
		public function Gate(startX:int, startY:int, endX:int, endY:int,
							 waterWorld:Level, num:int)
		{
			super(startX, startY, num);
			this.endX = endX;
			this.endY = endY;
						
			waterWorld.add(new Buoy(startX, startY, IMG));
			waterWorld.add(new Buoy(endX, endY, IMG));
			
			tang = new Point(endX - startX, endY - startY);
			midX = startX + tang.x / 2;
			midY = startY + tang.y / 2;
			halfLength = tang.length / 2;
			tang.normalize(1);
			norm = new Point(tang.y, -tang.x);
			
			numEntity.x = x + tang.x * halfLength;
			numEntity.y = y + tang.y * halfLength - 5;
		}
		
		override public function render():void
		{
			if(passed) Draw.linePlus(x + 20, y + 20, endX + 20, endY + 20, 0xFF00FF, 0.5, 30);
			else Draw.linePlus(x + 20, y + 20, endX + 20, endY + 20, 0xFFFFFF, 0.5, 30);
			super.render();
		}
		
	}

}
