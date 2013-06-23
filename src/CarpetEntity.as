package
{
	import flash.utils.Dictionary;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
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
							dist = - (thruster.pos[1] - (Conf.carpetSize[1] / 2));
							break;
						case Conf.down:
							thrusterAngle = a + Math.PI;
							dist = thruster.pos[0] - (Conf.carpetSize[0] / 2);
							break;
						case Conf.right:
							thrusterAngle = a - (Math.PI / 2);
							dist = thruster.pos[1] - (Conf.carpetSize[1] / 2);
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
			
			netMoment -= velA * Conf.carpetRotFriction;
			
			acnX = netForceX / Conf.carpetMass;
			acnY = netForceY / Conf.carpetMass;
			
			acnA = netMoment / Conf.carpetMOI;
			
			velX += acnX;
			velY += acnY;
			velA += acnA;
			
			x += velX;
			y += velY;
			a += velA;
			
			image.angle = 90 - Conf.radiansToDegrees(a);
		}
	}
}
