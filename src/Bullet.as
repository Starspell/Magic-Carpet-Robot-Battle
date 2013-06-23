package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	public class Bullet extends Entity
	{
		[Embed(source = '../assets/sprites/bullet.png')] private const IMG:Class;
		protected var velX:Number;
		protected var velY:Number;
		
		protected var lifeLeft:Number;
		
		public function Bullet(angle:Number, speed:Number, x:Number, y:Number)
		{
			graphic = new Image(IMG);
			
			velX = Math.cos(angle) * speed;
			velY = Math.sin(angle) * speed;
			
			this.x = x;
			this.y = y;
		}
		override public function update():void
		{
			x += velX;
			y += velY;
			
			// Destroy if off screen
			if (x < 0 || y < 0 || x > Conf.levelSize[0] || y > Conf.levelSize[1])
			{
				this.world.remove(this);
			}
		}
	}
	
}
