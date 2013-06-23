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
			sidesOrdered = [Conf.up, Conf.down, Conf.left, Conf.right];
			super(carpet, x, y);
			graphic = new Image(IMG);
		}
		
	}

}
