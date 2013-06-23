package
{
	import net.flashpunk.Entity;
	
	/**
	 * ...
	 * @author Sarah
	 */
	public class Block extends Entity
	{
		public var on:Boolean;
		public var carpet:CarpetWorld;
		public var _pos:Array;
		public var dir:int; // Should be Conf.up, down, left or right.
		protected var sidesOrdered:Array;
		
		public function Block(carpet:CarpetWorld, x:int, y:int)
		{
			this.carpet = carpet;
			pos = [x, y];
			var fpPos:Array = this.carpet.tileTL(x, y);
			super(fpPos[0], fpPos[1]);
		}
		public function get pos():Array
		{
			return _pos;
		}
		//DO NOT CALL ON PLAYER
		public function set pos(pos:Array):void
		{
			//sides Array = [up, left, down, right]
			var sides:Array = [false, false, false, false];
			_pos = pos;
			if(pos[1] == 1)
			{
				//Sets up to true
				sides[0] = true;
				on = true;
			}
			else if(pos[0] == 1)
			{
				//Sets left to true
				sides[1] = true;
				on = true;
			}
			else if(pos[1] == Conf.carpetSize[1] - 2)
			{
				//Sets down to true
				sides[2] = true;
				on = true;
			}
			else if(pos[0] == Conf.carpetSize[0] - 2)
			{
				//Sets right to true
				sides[3] = true;
				on = true;
			}
			else
			{
				on = false;
			}
			
			if (on == true)
			{
				setDir(sides);
			}
		}
		private function setDir(sides:Array):void
		{
			for (var i:int = 0; i < sidesOrdered.length; i++)
			{
				if (sides[sidesOrdered[i]] == true)
				{
					dir = sidesOrdered[i];
					break;
				}
			}
		}
	}
}
