package
{
	import flash.utils.Dictionary;
	import net.flashpunk.Entity;
	
	public class CarpetEntity extends Entity
	{
		private var a:Number; //The angle carpet is facing in radians ACW from +ve X axis.
		
		private var velA:Number; //Angular velocity.
		private var acnA:Number; //Angular acceleration.
		
		private var velX:Number;
		private var velY:Number;
		
		private var acnX:Number;
		private var acnY:Number;
		
		private var carpet:Object;
		
		public function CarpetEntity()
		{
			
		}
		
		override public function update():void
		{
			var netForceX:Number = 0;
			var netForceY:Number = 0;

			var netMoment:Number = 0;
			
			var dist:Number;
			
			//Handle thrusters.
			for (var thruster in carpet.thruster)
			{
				if (thruster.on)
				{
					var thrusterAngle:Number;
					
					switch(thruster.dir) 
					{
						case Conf.up:
							thrusterAngle = a;
							dist = - (pos[0] - (Conf.carpetSize[0] / 2));
							break;
						case Conf.left:
							thrusterAngle = a + (Math.PI / 2);
							dist = - (pos[1] - (Conf.carpetSize[1] / 2));
							break;
						case Conf.down:
							thrusterAngle = a + Math.PI;
							dist = pos[0] - (Conf.carpetSize[0] / 2);
							break;
						case Conf.right:
							thrusterAngle = a - (Math.PI / 2);
							dist = pos[1] - (Conf.carpetSize[1] / 2);
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
			for (var cannon in carpet.cannon)
			{
				
			}
			
			// Friction.
			netForceX -= velX * Conf.carpetFriction;
			netForceY -= velY * Conf.carpetFriction;
			
			acnX = netForceX / Conf.carpetMass;
			acnY = netForceY / Conf.carpetMass;
			
			acnA = netMoment / Conf.carpetMOI;
			
			velX += acnX;
			velY += acnY;
			velA += acnA;
			
			x += velX;
			y += velY;
			a += velA;
		}
	}
}
