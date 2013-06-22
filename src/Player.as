package
{
	import net.flashpunk.Entity;
	
	/**
	 * ...
	 * @author Sarah
	 */
	public class Player extends Entity
	{
		private var carpet:CarpetWorld;

		public function Player(carpet:CarpetWorld, startX:int, startY:int)
		{
			this.carpet = carpet;
// 			var pos:Array = this.carpet.getEntityPos(this, startX, startY);
// 			super(pos[0], pos[1]);
		}
		
	}

}
