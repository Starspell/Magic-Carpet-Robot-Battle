package
{
	import flash.utils.Dictionary;
	import net.flashpunk.Entity;
	
	public class CarpetEntity extends Entity
	{
		private var a:Number; //The angle carpet is facing in radians ACW from +ve X axis.
		
		private var velA:Number; //Angular velocity.
		private var acnA:Number; //Angular acceleration.
		private static const MOI:Number; //Moment of Inertia.
		
		private var velX:Number;
		private var velY:Number;
		
		private var acnX:Number;
		private var acnY:Number;
		
		private static const mass:Number;
		
		private var carpet:Object;
		
		public function CarpetEntity()
		{
			
		}
		
		override public function update():void
		{
			var netForceX:Number = 0;
			var netForceY:Number = 0;

			var netMomentX:Number = 0;
			var netMomentY:Number = 0;
			
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
							break;
						case Conf.left:
							thrusterAngle = a + (Math.PI / 2);
							break;
						case Conf.down:
							thrusterAngle = a + Math.PI;
							break;
						case Conf.right:
							thrusterAngle = a - (Math.PI / 2);
							break;
					}
					
					// Sort out force.
					netForceX += Math.cos(thrusterAngle) * Conf.thrusterForce;
					netForceY += Math.sin(thrusterAngle) * Conf.thrusterForce;
					
					// Sort out moment.
					
				}
			}
			
			//Handle cannons.
			for (var cannon in carpet.cannon)
			{
				
			}
			
			acnX = netForceX / mass;
			acnY = netForceY / mass;
		}
	}
}
