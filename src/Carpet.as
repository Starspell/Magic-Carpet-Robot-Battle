package
{
	import net.flashpunk.Entity
	
	public class Carpet extends Entity
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
		
		private var blocks:Array;
		
		public function Carpet():void
		{
			
		}
		
		override public function update():void
		{
			
			
			this.world.getType("block", blocks);
			for (var b in blocks)
			{
				if (b is Thruster)
				{
					
				}
				else if (b is Cannon)
				{
					
				}
			}
		}
	}
}