package
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Matthew
	 */
	public class Target extends Entity
	{
		[Embed(source = '../assets/sprites/target.png')] private const IMG:Class;
		public var targetNumber:int;
		
		public function Target(x:int, y:int, targetNum:int)
		{
			super(x, y);
			graphic = new Image(IMG);
			targetNumber = targetNum;
		}
		public function destroy():void
		{
			(world as Level).targetDestroyed(this);
		}
	}
}