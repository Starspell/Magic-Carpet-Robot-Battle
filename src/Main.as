package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import Level;
	import net.flashpunk.utils.Key;
	import net.flashpunk.Sfx;

	[SWF(width = '1000', height = '700')]
	public class Main extends Engine
	{		
		[Embed(source = '../assets/audio/waves.mp3')] private const MUSIC:Class;
		
		public static var devMode:Boolean = true;
		private var music:Sfx = new Sfx(MUSIC);
		
		public function Main()
		{
			super(1000, 700, 60, true);
			FP.world = new Level(0);
			
			if ( devMode )
			{
				FP.console.enable();
			}
			FP.console.toggleKey = Key.F1;
			
			music.loop();
		}
	}
}
