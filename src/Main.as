package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import Level;
	import net.flashpunk.utils.Key;

	[SWF(width = '1000', height = '700')]
	public class Main extends Engine
	{
		public static var devMode:Boolean = false;
		
		public function Main()
		{
			super(1000, 700, 60, true);
			FP.world = new Level();
			
			if ( devMode )
			{
				FP.console.enable();
			}
			FP.console.toggleKey = Key.F1;
		}
	}
}
