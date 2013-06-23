package
{
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Sarah
	 */
	public class Thruster extends InanimateBlock
	{
		[Embed(source = '../assets/sprites/thruster.png')] private const IMG:Class;
		
		public function Thruster(carpet:CarpetWorld, x:int, y:int)
		{
			sidesOrdered = [0, 2, 1, 3];
			super(carpet, x, y);
			graphic = new Image(IMG);
		}
		
	}

}
