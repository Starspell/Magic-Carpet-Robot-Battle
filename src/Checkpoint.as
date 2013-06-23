package
{
	import net.flashpunk.Entity;
	
	/**
	 * ...
	 * @author Matthew
	 */
	public class Checkpoint extends Entity
	{
		public var num:int;
		
		public function Checkpoint(x:int, y:int, num:int)
		{
			super(x, y);
			this.num = num;
		}
		public function pass():void
		{
			(world as Level).checkpointPassed(this);
		}
	}
}
