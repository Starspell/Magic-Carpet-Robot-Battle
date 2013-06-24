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
// 		[Embed(source = '../assets/fonts/AnonymousProB.ttf', embedAsCFF = "false", fontFamily = 'My Font')] private const FONT:Class;
		
// 		public var num:int;
		
		public var passed:Boolean = false;
		
		protected var numEntity:Entity;
		
		public function Checkpoint(x:int, y:int)//, num:int)
		{
			super(x, y);
// 			this.num = num;
			
// 			Text.font = "My Font";
// 			var fontTemp:Text = new Text(String(num + 1));
// 			fontTemp.size = 35;
// 			fontTemp.color = 0x8AD4F1;
			// I want to add a black / dark surround to the lettering
			// Not sure how to do it
			//fontTemp.setStyle("outline", );
// 			numEntity = new Entity(x, y, fontTemp);
		}
		
		public function pass():void
		{
			if ((world as Level).checkpointPassed(this)) passed = true;
		}
		
		override public function render():void
		{
			super.render();
// 			numEntity.render();
		}
	}
}
