package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	public class Main extends Engine
	{
		public function Main()
		{
			super(1000, 700, 60, false);
			
			FP.world = new Level();
		}
	}
}
