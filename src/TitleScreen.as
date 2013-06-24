package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.TiledImage;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	
	public class TitleScreen extends World
	{
		[Embed(source = '../assets/sprites/sea.png')] private const SEA:Class;
		[Embed(source = '../assets/sprites/title.png')] private const TITLE:Class;
		
		private var title:Image;
		private var sea:TiledImage;
		private var seaMoveLeft:Boolean;
		private var seaEnt:Entity;
		
		public function TitleScreen()
		{
			sea = new TiledImage(SEA, 1100, 700);
			title = new Image(TITLE);
			var titleEnt:Entity = addGraphic(title);
			titleEnt.layer = 0;
			titleEnt.x = 150; titleEnt.y = 100;
			seaEnt = addGraphic(sea);
			seaEnt.layer = 1;
			seaEnt.x = -50;
		}
		
		override public function update():void
		{
			if ( seaMoveLeft )
			{
				if ( seaEnt.x > -50 ) seaEnt.x -= Conf.seaMovementSpeed;
				else seaMoveLeft = false;
			}
			else
			{
				if ( seaEnt.x < -30 ) seaEnt.x += Conf.seaMovementSpeed;
				else seaMoveLeft = true;
			}
			
			if (Input.pressed(Key.ENTER))
				FP.world = new Level(0, [2]);
		}
	}
}