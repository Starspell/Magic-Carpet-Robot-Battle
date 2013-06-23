package
{
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Sarah
	 */
	public class Player extends Block
	{
		[Embed(source = '../assets/sprites/player.png')] private const IMG:Class;
		private var canMove:Boolean = true;
		private var sprite:Spritemap;

		public function Player(carpet:CarpetWorld, x:int, y:int)
		{
			super(carpet, x, y);
			sprite = new Spritemap(IMG, 40, 40);
			graphic = sprite;
			sprite.add("up", [0], 0, false);
			sprite.add("right", [1], 0, false);
			sprite.add("down", [2], 0, false);
			sprite.add("left", [3], 0, false);
		}
		override public function update():void
		{
			var dx:int = 0;
			var dy:int = 0;
			
			if (!canMove)
			{
				return;
			}
			
			dx = int(Input.check(Key.RIGHT)) - int(Input.check(Key.LEFT));
			dy = int(Input.check(Key.DOWN)) - int(Input.check(Key.UP));
			
			//Dual input doesn't result in movemenet
			if ((dx == 0 && dy == 0) || (dx != 0 && dy != 0))
			{
				return;
			}
			
			//Sprite Animations
			if (dx > 0)
			{
				dir = Conf.right;
				sprite.play("right");
			}
			
			if (dx < 0)
			{
				dir = Conf.left;
				sprite.play("left");
			}
			
			if (dy > 0)
			{
				dir = Conf.down;
				sprite.play("down");
			}
			
			if (dy < 0)
			{
				dir = Conf.up;
				sprite.play("up");
			}
			
			//Boundary detection
			if (dx == 1 && x == (Conf.carpetSize[0] - 1) * Conf.carpetTileSize[0])
			{
				return;
			}
			
			if (dx == -1 && x == 0)
			{
				return;
			}
			
			if (dy == 1 && y == (Conf.carpetSize[1] - 1) * Conf.carpetTileSize[1])
			{
				return;
			}
			
			if (dy == -1 && y == 0)
			{
				return;
			}
			canMove = false;
			
			FP.tween(this, { x: x + dx * Conf.carpetTileSize[0], y: y + dy * Conf.carpetTileSize[1] }, Conf.tweenTime, { tweener: FP.tweener, complete: moveDone } );
		}
		private function moveDone():void
		{
			canMove = true;
		}
	}
}
