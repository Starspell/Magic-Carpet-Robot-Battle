package
{
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Sarah
	 */
	public class Cannon extends Block
	{
		[Embed(source = '../assets/sprites/cannon.png')] private const IMG:Class;

		public function Cannon(carpet:CarpetWorld, x:int, y:int)
		{
			super(carpet, x, y);
			sidesOrdered = [1, 3, 0, 2];
			graphic = new Image(IMG);
		}
		
	}

}
