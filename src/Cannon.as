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
			sidesOrdered = [1, 3, 0, 2];
			super(carpet, x, y);
			var g:Image = new Image(IMG);
			g.originX = Conf.carpetTileSize[0] / 2;
			g.originY = Conf.carpetTileSize[1] / 2;
			graphic = g;
		}
		
	}

}
