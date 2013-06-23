package
{
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Sarah
	 */
	public class Cannon extends InanimateBlock
	{
		[Embed(source = '../assets/sprites/cannon.png')] private const IMG:Class;

		public function Cannon(carpet:CarpetWorld, x:int, y:int)
		{
			sidesOrdered = [1, 3, 0, 2];
			super(carpet, x, y);
			graphic = new Image(IMG);
		}
		
	}

}
