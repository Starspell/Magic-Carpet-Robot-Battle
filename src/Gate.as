package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;
	/**
	 * ...
	 * @author Sarah
	 */
	public class Gate extends Buoy 
	{
		[Embed(source = '../assets/sprites/gateCone.png')] private const IMG:Class;
		
		public var endGate:Entity;
		
		private var endX:int;
		private var endY:int;
		
		public var norm:Point;
		public var tang:Point;
		
		public var halfLength:Number;
		
		public var passed:Boolean = false;
		
		public function Gate(startX:int, startY:int, endX:int = 0, endY:int = 0, waterWorld:Level = null) 
		{
			super(startX, startY);
			
			this.endX = endX;
			this.endY = endY;
			
			tang = new Point(endX - startX, endY - startY);
			halfLength = tang.length / 2;
			tang.normalize(1);
			norm = new Point(tang.y, -tang.x);
			
			graphic = new Image(IMG);
			
			if ( waterWorld )
			{
				endGate = waterWorld.addGraphic(new Image(IMG), -1, endX, endY);
				endGate.setHitbox(40, 40);
				endGate.type = "buoy";
			}
		}
		
		override public function render():void
		{
			if(passed) Draw.linePlus(x + 20, y + 20, endX + 20, endY + 20, 0xFF00FF, 0.5, 30);
			else Draw.linePlus(x + 20, y + 20, endX + 20, endY + 20, 0xFFFFFF, 0.5, 30);
			super.render();
			
		}
	}

}