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
			offGraphic = new Image(IMG);
			onGraphic = new Spritemap(IMGON, 40, 40);
			onGraphic.add("up", [0], 0, false);
			onGraphic.add("left", [1], 0, false);
			onGraphic.add("down", [2], 0, false);
			onGraphic.add("right", [3], 0, false);
			graphic = onGraphic;
			on = true;
			graphic = onGraphic;
			super(carpet, x, y);
			
			//flare = new Image(FLARE);
			//carpet.addGraphic(flare);
			
			//flare.visible = false;
			//flare.originX = x * Conf.carpetTileSize[0] + 20;
			
			setHitbox(40, 40);
		}

		private function updateGraphic():void {
			if (on)
			{
				graphic = onGraphic;
				if (dir == Conf.up) onGraphic.play("up");
				else if (dir == Conf.left) onGraphic.play("left");
				else if (dir == Conf.down) onGraphic.play("down");
				else onGraphic.play("right"); //dir == Conf.right
			}
			else //off
			{
				graphic = offGraphic;
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
		
		override public function update():void
		{
			if (on)
			{
				flare.visible = true;
			}
		}
	}

}
