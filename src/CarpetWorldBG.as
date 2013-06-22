package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;

	public class CarpetWorldBG extends Entity
	{
		[Embed(source = '../assets/sprites/carpetarea.png')] private const CARPET:Class;

		public function CarpetWorldBG()
		{
			super();
			layer = 1;
			graphic = new Image(CARPET);
		}
	}
}
