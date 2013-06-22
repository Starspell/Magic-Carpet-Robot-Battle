package
{
	import net.flashpunk.Entity;
	
	/**
	 * ...
	 * @author Sarah
	 */
	public class Player extends Block
	{
		[Embed(source = '../assets/sprites/player.png')] private const PLAYER:Class;

		public function Player(carpet:CarpetWorld, x:int, y:int)
		{
			super(carpet, x, y);
		}
		
	}

}
