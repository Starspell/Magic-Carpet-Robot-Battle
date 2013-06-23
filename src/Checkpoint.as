package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	
	/**
	 * ...
	 * @author Matthew
	 */
	public class Checkpoint extends Entity
	{
		[Embed(source = '../assets/fonts/AnonymousProB.ttf', embedAsCFF = "false", fontFamily = 'My Font')] private const FONT:Class;
		
		public var num:int;
		
		public var passed:Boolean = false;
		
		protected var numEntity:Entity;
		
		public function Checkpoint(x:int, y:int, num:int)
		{
			super(x, y);
			this.num = num;
			
			Text.font = "My Font";
			var fontTemp:Text = new Text(String(num));
			fontTemp.size = 35;
			numEntity = new Entity(x, y, fontTemp);
		}
		
		public function pass():void
		{
			passed = true;
			(world as Level).checkpointPassed(this);
		}
	}
}
