package
{
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Sarah
	 */
	public class Player extends Block
	{
		private var sprite:Spritemap;
		private var keys:Array;

		[Embed(source = '../assets/sprites/player.png')] private const IMG:Class;

		public function Player(carpet:CarpetWorld, x:int, y:int, pID:int)
		{
			super(carpet, x, y);
			sprite = new Spritemap(IMG, 40, 40);
			graphic = sprite;
			setDir(Conf.up);
			if (pID < Conf.playerKeys.length) {
				keys = Conf.playerKeys[pID];
			} else {
				throw new Error("no configuration for player ID " + pID);
			}
		}

		private function setDir(dir:int):void {
			this.dir = dir;
			sprite.setFrame(dir);
		}

		override public function update():void
		{
			if (!canMove) return;

			var i:int, j:int;
			// determine input directions
			var dp:Array = [0, 0];
			var dirs:Array = [false, false, false, false];
			for (i = 0; i < 2; i++) {
				dp[i] = (int(Input.check(keys[i + 2]))
						 - int(Input.check(keys[i])));
			}
			for (i = 0; i < 2; i++) {
				if (dp[i] > 0) dirs[i + 2] = true;
				else if (dp[i] < 0) dirs[i] = true;
			}
			// choose a direction
			var nDirs:int = 0;
			var gotLast:Boolean = false;
			var dir:int;
			for (i = 0; i < 4; i++) {
				if (dirs[i]) {
					if (i == this.dir) gotLast = true;
					else dir = i;
					nDirs += int(dirs[i]);
				}
			}
			if (!(nDirs == 1 || (nDirs == 2 && gotLast))) {
				// multiple directions: don't move
				return;
			}
			if (!(gotLast && nDirs == 1)) setDir(dir);
			// boundary detection
			i = this.dir % 2; // axis
			j = (this.dir >= 2) ? 1 : -1; // direction on this axis
			if (pos[i] + j == int(j == 1) * (Conf.carpetSize[i] - 1) + j) {
				return;
			}
			// move
			dp[i] = j;
			dp[int(!i)] = 0;
			if (carpet.isFree(pos[0] + dp[0], pos[1] + dp[1])) {
				canMove = false;
				carpet.moveTo(this, pos[0] + dp[0], pos[1] + dp[1], moveDone);
			}
		}
	}
}
