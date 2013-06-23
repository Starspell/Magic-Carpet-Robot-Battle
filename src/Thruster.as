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
		[Embed(source = '../assets/sprites/thrusteron.png')] private const IMGON:Class;
		
		public var offGraphic:Image;
		public var onGraphic:Image;
		
		public var on:Boolean;
		
		public function Thruster(carpet:CarpetWorld, x:int, y:int)
		{
			sidesOrdered = [0, 2, 1, 3];
			super(carpet, x, y);
			offGraphic = new Image(IMG);
			onGraphic = new Image(IMGON);
			on = true;
			graphic = onGraphic;
			setHitbox(40, 40);
			
			offGraphic.originX = Conf.carpetTileSize[0]/2;
			onGraphic.originX = Conf.carpetTileSize[0]/2;
			offGraphic.originY = Conf.carpetTileSize[1]/2; 
			onGraphic.originY = Conf.carpetTileSize[1]/2;
		}
		
		override public function update():void
		{
			if (on)
			{
				graphic = onGraphic;
				if (dir == Conf.up) onGraphic.angle = 0;
				else if (dir == Conf.left) onGraphic.angle = 90;
				else if (dir == Conf.down) onGraphic.angle = 180;
				else onGraphic.angle = 270; //dir == Conf.right
			}
			else //off
			{
				graphic = offGraphic;
			}
		}
		
	}

}
