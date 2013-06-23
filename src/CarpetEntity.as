package
{
	import flash.utils.Dictionary;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;
	
	public class CarpetEntity extends Entity
	{
		[Embed(source = '../assets/sprites/carpetentity.png')] private const CARPET:Class;
		
		private var a:Number = 0; //The angle carpet is facing in radians ACW from +ve X axis.
		
		private var velA:Number = 0; //Angular velocity.
		private var acnA:Number = 0; //Angular acceleration.
		
		private var velX:Number = 0;
		private var velY:Number = 0;
		
		private var acnX:Number = 0;
		private var acnY:Number = 0;
		
		private var blocks:Object;
		
		private var image:Image;
		
		public function CarpetEntity(blocks:Object)
		{
			this.blocks = blocks;
			image = new Image(CARPET);
			a = Math.PI / 2
			image.originX = 20;
			image.originY = 30;
			super(500, 350, image);
			setHitbox(40, 60);
			layer = -10;
		}
		
		override public function update():void
		{
			var netForceX:Number = 0;
			var netForceY:Number = 0;

			var netMoment:Number = 0;
			
			var dist:Number;
			
			//Handle thrusters.
			for each (var thruster:Thruster in blocks.thruster)
			{
				if (thruster.on)
				{
					var thrusterAngle:Number;
					
					switch(thruster.dir)
					{
						case Conf.up:
							thrusterAngle = a;
							dist = - (thruster.pos[0] - (Conf.carpetSize[0] / 2));
							break;
						case Conf.left:
							thrusterAngle = a + (Math.PI / 2);
							dist = thruster.pos[1] - (Conf.carpetSize[1] / 2);
							break;
						case Conf.down:
							thrusterAngle = a + Math.PI;
							dist = thruster.pos[0] - (Conf.carpetSize[0] / 2);
							break;
						case Conf.right:
							thrusterAngle = a - (Math.PI / 2);
							dist = -(thruster.pos[1] - (Conf.carpetSize[1] / 2));
							break;
					}
					
					// Sort out force.
					netForceX -= Math.cos(thrusterAngle) * Conf.thrusterForce;
					netForceY -= Math.sin(thrusterAngle) * Conf.thrusterForce;
					
					// Sort out moment.
					netMoment += dist * Conf.thrusterForce;
				}
			}
			
			//Handle cannons.
			for each (var cannon:Cannon in blocks.cannon)
			{
				
			}
			
			// Friction.
			netForceX -= velX * Conf.carpetFriction;
			netForceY -= velY * Conf.carpetFriction;
			
			netMoment -= velA * velA * Conf.carpetRotFriction;
			
			acnX = netForceX / Conf.carpetMass;
			acnY = netForceY / Conf.carpetMass;
			
			acnA = netMoment / Conf.carpetMOI;
			
			velX += acnX;
			velY += acnY;
			velA += acnA;
			
			// Smoothly moves very low speed to 0.
			velA *= 0.99;
			velX *= 0.99;
			velY *= 0.99;
			
			x -= velX;
			y -= velY;
			a -= velA;
			
			image.angle = 90 - Conf.radiansToDegrees(a);
			fire(1, 1, 1);
		}
		
		// Fire a bullet from a cannon at carpetx,carpetY on carpet, in direction dir.
		public function fire(carpetX:int, carpetY:int, dir:int):void
		{
			var scaledX:Number = 5 * (carpetX + 0.5 - (Conf.carpetSize[0] / 2));
			var scaledY:Number =  5 * (carpetY + 0.5 - (Conf.carpetSize[1] / 2));
			
			var cannonA:Number = a - (Math.PI / 2);
			
			var rotatedX:Number = scaledX * Math.cos(cannonA) - scaledY * Math.sin(cannonA);
			var rotatedY:Number = scaledX * Math.sin(cannonA) + scaledY * Math.cos(cannonA);

			var bulletA:Number;
			
			switch(dir)
			{
				case Conf.up:
					bulletA = a;
					break;
				case Conf.left:
					bulletA = a + (Math.PI / 2);
					break;
				case Conf.down:
					bulletA = -a;
					break;
				case Conf.right:
					bulletA = a - (Math.PI / 2);
					break;
			}
			this.world.add(new Bullet(Conf.bulletSpeed * Math.cos(bulletA + Math.PI) + velX, 
				Conf.bulletSpeed * Math.sin(bulletA + Math.PI) + velY, 
				this.x + rotatedX, 
				this.y + rotatedY));
		}
	}
}
