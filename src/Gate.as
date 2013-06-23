package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;
	/**
	 * ...
	 * @author Sarah
	 */
	public class Gate extends Checkpoint
	{
		[Embed(source = '../assets/sprites/gateCone.png')] private const IMG:Class;
		
		public var endGate:Entity;
		
		private var endX:int;
		private var endY:int;
		
		public function Gate(startX:int, startY:int, endX:int, endY:int,
							 waterWorld:Level, num:int)
		{
			super(startX, startY, num);
			this.endX = endX;
			this.endY = endY;

			waterWorld.add(new Buoy(startX, startY, IMG));
			waterWorld.add(new Buoy(endX, endY, IMG));
		}
		
		override public function render():void
		{
			Draw.linePlus(x + 20, y + 20, endX + 20, endY + 20, 0xFFFFFF, 0.5, 30);
			super.render();
		}
	}

}
