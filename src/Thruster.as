package
{
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Sarah
	 */
	public class Thruster extends Block
	{
<<<<<<< HEAD
=======
		public var on:Boolean;

		[Embed(source = '../assets/sprites/thruster.png')] private const IMG:Class;
>>>>>>> 08f13cac5bed4ccd5a8fcce239df59a1c1f29611
		
		public function Thruster(carpet:CarpetWorld, x:int, y:int)
		{
			super(carpet, x, y);
<<<<<<< HEAD
			sidesOrdered = [0, 2, 1, 3]
=======
			graphic = new Image(IMG);
			on = true;
>>>>>>> 08f13cac5bed4ccd5a8fcce239df59a1c1f29611
		}
		
	}

}
