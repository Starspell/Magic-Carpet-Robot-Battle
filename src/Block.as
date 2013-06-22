package
{
	import net.flashpunk.Entity;
	
	/**
	 * ...
	 * @author Sarah
	 */
	public class Block extends Entity 
	{
		public var carpet:CarpetWorld;
		public var pos:Array;
		public var dir:int; // Should be Conf.up, down, left or right.
		
		public function Block(carpet:CarpetWorld, x:int, y:int)
		{
			this.carpet = carpet;
			pos = [x, y];
			var fpPos:Array = this.carpet.tileTL(x, y);
			super(fpPos[0], fpPos[1]);
		}
		
	}

}
