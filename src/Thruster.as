package
{
	import flash.display.Sprite;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Sarah
	 */
	public class Thruster extends InanimateBlock
	{
		[Embed(source = '../assets/sprites/thruster.png')] private const IMG:Class;
		[Embed(source = '../assets/sprites/flare.png')] private const FLARE:Class;
		[Embed(source = '../assets/sprites/thrusteron.png')] private const IMGON:Class;
		
		public var offGraphic:Image;
		public var onGraphic:Spritemap;
		private var flare:Image;
		
		public function Thruster(carpet:CarpetWorld, x:int, y:int)
		{
			sidesOrdered = [Conf.up, Conf.down, Conf.left, Conf.right];
			
			flare = new Image(FLARE);
			carpet.addGraphic(flare, -1);
			flare.visible = false;
			
			offGraphic = new Image(IMG);
			
			onGraphic = new Spritemap(IMGON, 40, 40);
			onGraphic.add("up", [0], 0, false);
			onGraphic.add("left", [1], 0, false);
			onGraphic.add("down", [2], 0, false);
			onGraphic.add("right", [3], 0, false);
			
			super(carpet, x, y);
			
			updateFlare();
		}
		
		private function updateFlare():void
		{
			flare.x = x + Conf.carpetTileSize[0] / 2;
			flare.y = y + Conf.carpetTileSize[1] / 2;
			flare.originX = Conf.carpetTileSize[0] / 2;
		}

		private function updateGraphic():void {
			if (on)
			{
				graphic = onGraphic;
				flare.visible = true;
				updateFlare();
				
				if (dir == Conf.up) 
				{
					onGraphic.play("up");
					flare.angle = 180;
				}
				else if (dir == Conf.left)
				{
					onGraphic.play("left");
					flare.angle = 270;
				}
				else if (dir == Conf.down)
				{
					onGraphic.play("down");
					flare.angle = 0;
				}
				else 
				{
					onGraphic.play("right"); //dir == Conf.right
					flare.angle = 90;
				}
			}
			else //off
			{
				graphic = offGraphic;
				flare.visible = false;
			}
		}

		public override function set on(on:Boolean):void {
			super.on = on;
			updateGraphic();
		}
		
		protected override function setDir(sides:Array):void
		{
			super.setDir(sides);
			updateGraphic();
		}
	}

}
