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
				switch(thruster.dir) 
				{
					case 0: //fore
						
						break;
					case 1: //port
						break;
					case 2: //aft
						break;
					case 3: //starboard
						break;
				}
			}
			
			//Handle cannons.
			for (var cannon in carpet.cannon)
			{
				
			}
		}
	}
}
