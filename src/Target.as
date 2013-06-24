package
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author Matthew
	 */
	public class Target extends Checkpoint
	{
		[Embed(source = '../assets/sprites/target.png')] private const IMG:Class;
		[Embed(source = '../assets/audio/explosion.mp3')] private const EXPLODE:Class;
		
		private var explodeSound:Sfx = new Sfx(EXPLODE);
		
		public function Target(x:int, y:int)//, num:int)
		{
			super(x, y);//, num);
			graphic = new Image(IMG);
			setHitbox(40, 40);
			type = "Target";
			
// 			numEntity.x = x + 10;
// 			numEntity.y = y;
		}
		
		override public function pass():void
		{
			super.pass();
			explodeSound.play();
		}
	}
}
