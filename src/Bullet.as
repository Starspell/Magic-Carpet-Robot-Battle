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
		
		public function Bullet(velX:Number, velY:Number, x:Number, y:Number)
		{
			var i:Image = new Image(IMG);
			setHitbox(20, 20, 10, 10);
			i.originX = 10;
			i.originY = 10;

			graphic = i;
			
			this.velX = velX;
			this.velY = velY;
			
			this.x = x;
			this.y = y;
			
			
			
			layer = -3;
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
