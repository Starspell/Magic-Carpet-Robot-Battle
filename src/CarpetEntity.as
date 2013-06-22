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
		
		private var Carpet:Dictionary;
		
		public function CarpetEntity()
		{
			
		}
		
		override public function update():void
		{
			var netForceX:Number = 0;
			var netForceY:Number = 0;

			var netMomentX:Number = 0;
			var netMomentY:Number = 0;
			
			for (var block in Carpet)
			{
				if (block is Thruster)
				{
					
				}
				else if (block is Cannon)
				{
					
				}
			}
		}
	}
}
