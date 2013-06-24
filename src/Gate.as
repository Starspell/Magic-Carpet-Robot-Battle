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
		[Embed(source = '../assets/audio/checkpoint.mp3')] private const GATE:Class;
// 		[Embed(source = '../assets/audio/wrongcheckpoint.mp3')] private const WRONG:Class;
		
		public var endGate:Entity;
		
		public var midX:Number;
		public var midY:Number;
		
		private var endX:int;
		private var endY:int;
		
		public var norm:Point;
		public var tang:Point; // vector: end - start
		
		public var halfLength:Number;

		private var passGate:Sfx = new Sfx(GATE);
// 		private var passWrongGate:Sfx = new Sfx(WRONG);
		
		public function Gate(startX:int, startY:int, endX:int, endY:int,
							 waterWorld:Level)//, num:int)
		{
			super(startX, startY);//, num);
			this.endX = endX;
			this.endY = endY;
						
			var hw:int = waterWorld.add(new Buoy(startX, startY, IMG)).halfWidth;
			var hh:int = waterWorld.add(new Buoy(endX, endY, IMG)).halfHeight;
			
			tang = new Point(endX - startX, endY - startY);
			midX = startX + hw + tang.x / 2;
			midY = startY + hh + tang.y / 2;
			halfLength = tang.length / 2;
			tang.normalize(1);
			norm = new Point(tang.y, -tang.x);
			
// 			numEntity.x = x + tang.x * halfLength;
// 			numEntity.y = y + tang.y * halfLength;
		}

		override public function pass():void
		{
			if (!passed) {
				if ((world as Level).checkpointPassed(this)) {
					passed = true;
					passGate.play();
				} else {
					// wrong gate order
// 					passWrongGate.play();
				}
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
