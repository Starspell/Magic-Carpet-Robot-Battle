package
{
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Sarah
	 */
	public class Thruster extends Block
	{
		[Embed(source = '../assets/sprites/thruster.png')] private const IMG:Class;
		
		public function Thruster(carpet:CarpetWorld, x:int, y:int)
		{
			super(carpet, x, y);
			sidesOrdered = [0, 2, 1, 3];
			graphic = new Image(IMG);
		}
		
	}

}
