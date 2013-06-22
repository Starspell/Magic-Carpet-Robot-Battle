package
{
	import net.flashpunk.World;

	public class CarpetWorld extends World
	{
		public var player:Player;

		public function CarpetWorld()
		{
			player = new Player(this, 0, 0);
			add(player);
		}
	}
}
