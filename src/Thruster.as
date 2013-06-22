package
{
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Sarah
	 */
	public class Thruster extends Block
	{
		public var on:Boolean;

		[Embed(source = '../assets/sprites/thruster.png')] private const IMG:Class;
		
		public function Thruster(carpet:CarpetWorld, x:int, y:int)
		{
			super(carpet, x, y);
			graphic = new Image(IMG);
		}
		
	}

}
