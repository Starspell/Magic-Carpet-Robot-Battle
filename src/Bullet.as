package
{
	import net.flashpunk.Entity;
	
	public class Bullet extends Entity
	{
		protected var velX:Number;
		protected var velY:Number;
		
		protected var lifeLeft:Number;
		
		public function Bullet(angle:Number, speed:Number, x:Number, y:Number)
		{
			velX = Math.cos(angle) * speed;
			velY = Math.sin(angle) * speed;
			
			this.x = x;
			this.y = y;
		}
		override public function update()
		{
			x += velX;
			y += velY;
		}
	}
	
}
