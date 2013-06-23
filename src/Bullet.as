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
			moveBy(velX, velY, "Target")
			x += velX;
			y += velY;
			
			var tempWorld:Level = this.world as Level;
			
			if ( !tempWorld )
			{
				return;
			}
			
			// Destroy if off screen
			if (x < tempWorld.worldBoundaryCoords[0].x || y < tempWorld.worldBoundaryCoords[0].y 
				|| x > tempWorld.worldBoundaryCoords[1].x || y > tempWorld.worldBoundaryCoords[1].y)
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
			this.world.add(new Explosion(e.x + e.halfWidth, e.y + e.halfHeight));
			this.world.remove(this);
		}
	}
}
