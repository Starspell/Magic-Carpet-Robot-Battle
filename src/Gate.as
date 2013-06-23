package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
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
		
		public function Gate(startX:int, startY:int, endX:int = 0, endY:int = 0, waterWorld:Level = null) 
		{
			super(startX, startY);
			
			this.endX = endX;
			this.endY = endY;
			
			graphic = new Image(IMG);
			
			if ( waterWorld )
			{
				endGate = waterWorld.addGraphic(new Image(IMG), -1, endX, endY);
				endGate.setHitbox(40, 40);
				endGate.type = "buoy";
			}
		}
		
	}

}