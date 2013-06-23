package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Sarah
	 */
	public class Buoy extends Entity 
	{
		[Embed(source = '../assets/sprites/buoy.png')] private const IMG:Class;
		
		public function Buoy(startX:int, startY:int) 
		{
			super(startX, startY, new Image(IMG));
			
			setHitbox(40, 40);
			type = "buoy";
		}
		
	}

}