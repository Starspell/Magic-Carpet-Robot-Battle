package
{
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Matthew
	 */
	public class Target extends Checkpoint
	{
		[Embed(source = '../assets/sprites/target.png')] private const IMG:Class;
		
		public function Target(x:int, y:int, num:int)
		{
			super(x, y, num);
			graphic = new Image(IMG);
			setHitbox(40, 40);
			type = "Target";
		}
	}
}
