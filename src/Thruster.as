package
{
	import flash.display.Sprite;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Sarah
	 */
	public class Thruster extends InanimateBlock
	{
		[Embed(source = '../assets/sprites/thruster.png')] private const IMG:Class;
		[Embed(source = '../assets/sprites/thrusteron.png')] private const IMGON:Class;
		[Embed(source = '../assets/sprites/flare.png')] private const FLARE:Class;
		
		public var offGraphic:Image;
		public var onGraphic:Spritemap;
		private var flare:Spritemap;
		
		public function Thruster(carpet:CarpetWorld, x:int, y:int)
		{
			sidesOrdered = [Conf.up, Conf.down, Conf.left, Conf.right];
			
			flare = new Spritemap(FLARE, 40, 60);
			carpet.addGraphic(flare, -1);
			flare.visible = false;
			flare.add("on", [0, 1, 2, 3], 5, true);
			flare.play("on");
			
			offGraphic = new Image(IMG);
			
			onGraphic = new Spritemap(IMGON, 40, 40);
			onGraphic.add("up", [0], 0, false);
			onGraphic.add("left", [1], 0, false);
			onGraphic.add("down", [2], 0, false);
			onGraphic.add("right", [3], 0, false);
			
			super(carpet, x, y);
			flare.originX = Conf.carpetTileSize[0] / 2;
			flare.x = this.x + Conf.carpetTileSize[0] / 2;
			flare.y = this.y + Conf.carpetTileSize[1] / 2;
		}
		
		override public function tweenTo(x:int, y:int, cb:Function):void
		{
			super.tweenTo(x, y, cb);
			FP.tween(flare,
				{
					x: x + Conf.carpetTileSize[0] / 2,
					y: y + Conf.carpetTileSize[1] / 2
				}, Conf.tweenTime, {tweener: FP.tweener, complete: cb}
			);
		}

		private function updateGraphic():void {
			if (on)
			{
				graphic = onGraphic;
				flare.visible = true;
				
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
