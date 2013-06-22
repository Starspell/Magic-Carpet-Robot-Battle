package
{
	import net.flashpunk.World;

	public class CarpetWorld extends World
	{
		public var player:Player;
		public var tilemap:CarpetTilemap;

		public function CarpetWorld()
		{
			tilemap = new CarpetTilemap();
			player = new Player(this, 0, 0);
			add(tilemap);
			add(player);
		}
	}
}
