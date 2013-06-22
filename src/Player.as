package
{
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Sarah
	 */
	public class Player extends Block
	{
		[Embed(source = '../assets/sprites/player.png')] private const IMG:Class;

		public function Player(carpet:CarpetWorld, x:int, y:int)
		{
			super(carpet, x, y);
			graphic = new Spritemap(IMG, 40, 40);
		}
		
	}

}
