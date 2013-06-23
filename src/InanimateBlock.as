package
{
	public class InanimateBlock extends Block
	{
		public var _on:Boolean;
		protected var sidesOrdered:Array;

		public function InanimateBlock(carpet:CarpetWorld, x:int, y:int)
		{
			super(carpet, x, y);
		}

		public function get on():Boolean {
			return _on;
		}

		public function set on(on:Boolean):void {
			this._on = on;
		}

		public override function set pos(pos:Array):void
		{
			super.pos = pos;
			//sides Array = [up, left, down, right]
			var sides:Array = [false, false, false, false];
			if(pos[1] == 1)
			{
				//Sets up to true
				sides[Conf.up] = true;
				on = true;
			}
			else if(pos[0] == 1)
			{
				//Sets left to true
				sides[Conf.left] = true;
				on = true;
			}
			else if(pos[1] == Conf.carpetSize[1] - 2)
			{
				//Sets down to true
				sides[Conf.down] = true;
				on = true;
			}
			else if(pos[0] == Conf.carpetSize[0] - 2)
			{
				//Sets right to true
				sides[Conf.right] = true;
				on = true;
			}
			else
			{
				on = false;
			}
			
			if (on)
			{
				trace(sides);
				setDir(sides);
			}
		}

		protected function setDir(sides:Array):void
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
