package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import Level;

	[SWF(width = '1000', height = '700')]
	public class Main extends Engine
	{
		public function Main()
		{
			super(1000, 700, 60, true);
			FP.world = new Level();
		}
	}
}
