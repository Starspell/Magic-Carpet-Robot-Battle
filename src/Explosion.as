package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	
	public class Explosion extends Entity
	{
		private var lifeTime:int;
		private var time:int;	
		
		private var emitter:Emitter;
		
		[Embed(source = '../assets/sprites/debris.png')] private const IMG:Class;
	
		public function Explosion(x:Number, y:Number, angle:Number, lifeTime:int = 60)
		{
			emitter = new Emitter(IMG, 100, 100);
			emitter.newType("explosion", [0]);
			emitter.setMotion("explosion", angle, 50, 10, 90, 20, 1);
			emitter.setAlpha("explosion", 1, 0);
			graphic = emitter;
			this.x = x; this.y = y;
			this.lifeTime = lifeTime;
			
			layer = -100000000000001;
		}
		
		override public function update():void
		{
			time++;
			if (time > lifeTime)
			{
				if(this.world)
					this.world.remove(this);
			}
			emitter.emit("explosion", 0, 0);
		}
	}
}