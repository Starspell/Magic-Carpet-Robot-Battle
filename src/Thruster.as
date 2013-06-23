package
{
	import flash.display.Sprite;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Sarah
	 */
	public class Thruster extends Block
	{
		[Embed(source = '../assets/sprites/thruster.png')] private const IMG:Class;
		[Embed(source = '../assets/sprites/flare.png')] private const FLARE:Class;
		
		private var flare:Image;
		
		public function Thruster(carpet:CarpetWorld, x:int, y:int)
		{
			super(carpet, x, y);
			sidesOrdered = [0, 2, 1, 3];
			graphic = new Image(IMG);
			flare = new Image(FLARE);
			carpet.addGraphic(flare);
			
			flare.visible = false;
			flare.originX = x * Conf.carpetTileSize[0] + 20;
			
			on = true;
		}
		
		override public function update():void
		{
			if (on)
			{
				flare.visible = true;
			}
		}
	}

}
