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
			sidesOrdered = [Conf.left, Conf.right, Conf.up, Conf.down];
			super(carpet, x, y);
			graphic = new Image(IMG);
		}
	}
}
