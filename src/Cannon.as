package
{
	/**
	 * ...
	 * @author Sarah
	 */
	public class Cannon extends Block
	{

		public function Cannon(carpet:CarpetWorld, x:int, y:int)
		{
			super(carpet, x, y);
			sidesOrdered = [1, 3, 0, 2]
		}
		
	}

}
