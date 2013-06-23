package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	
	public class Bullet extends Entity
	{
		[Embed(source = '../assets/sprites/bullet.png')] private const IMG:Class;
		protected var velX:Number;
		protected var velY:Number;
		private var animation:Spritemap;
		
		protected var lifeLeft:Number;
		
		public function Bullet(velX:Number, velY:Number, x:Number, y:Number)
		{
			animation = new Spritemap(IMG, 20, 20);
			animation.add("blob", [0, 1], 0.1, true);
			animation.play("blob");
			graphic = animation;
			
			setHitbox(20, 20, 10, 10);
			animation.originX = 10;
			animation.originY = 10;
			
			this.velX = velX;
			this.velY = velY;
			
			this.x = x;
			this.y = y;
			
			
			
			layer = -3;
		}
		override public function update():void
		{
			moveBy(velX, velY, "Target")
			x += velX;
			y += velY;
			
			// Destroy if off screen
			if (x < 0 || y < 0 || x > Conf.levelSize[0] || y > Conf.levelSize[1])
			{
				this.world.remove(this);
			}
		}
		override public function moveCollideX(e:Entity):Boolean
		{
			(e as Checkpoint).pass();
			if (e is Target) explode(e);
			return false;
		}
		
		override public function moveCollideY(e:Entity):Boolean
		{
			(e as Checkpoint).pass();
			if (e is Target) explode(e);
			return false;
		}
		
		private function explode(e:Entity):void
		{
			this.world.add(new Explosion(e.x, e.y, - Conf.radiansToDegrees(Math.atan2(velY, velX))));
			this.world.remove(this);
		}
	}
}
