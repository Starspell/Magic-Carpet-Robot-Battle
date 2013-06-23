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
		private var moveKeys:Array;
		private var grabKey:String;
		private var isMoving:Boolean = false;
		private var moveCounter:int;
		private var moveDir:int;
		private var grabbedBlock:Block;

		[Embed(source = '../assets/sprites/player.png')] private const IMG:Class;

		public function Player(carpet:CarpetWorld, x:int, y:int, pID:int)
		{
			super(carpet, x, y);
			sprite = new Spritemap(IMG, 40, 40);
			graphic = sprite;
			setDir(Conf.up);
			if (pID < Conf.playerKeys.length) {
				moveKeys = Conf.playerKeys[pID].move;
				var args:Array = Conf.playerKeys[pID].grab.slice();
				args.unshift("grab" + pID);
				Input.define.apply(null, args);
				grabKey = "grab" + pID;
			} else {
				throw new Error("no configuration for player ID " + pID);
			}
			moveDir = dir;
		}

		private function setDir(dir:int):void {
			this.dir = dir;
			sprite.setFrame(dir);
		}

		override public function update():void
		{
			if (!canMove) return;
			if (Input.pressed(grabKey)) {
				var b:Block = carpet.blockInDir(pos, dir);
				if (b !== null) {
					grabbedBlock = b;
				}
			}
			if (!Input.check(grabKey)) {
				grabbedBlock = null;
			}

			var i:int, j:int;
			// determine input directions
			var dp:Array = [0, 0];
			var dirs:Array = [false, false, false, false];
			for (i = 0; i < 2; i++) {
				dp[i] = (int(Input.check(moveKeys[i + 2]))
						 - int(Input.check(moveKeys[i])));
			}
			for (i = 0; i < 2; i++) {
				if (dp[i] > 0) dirs[i + 2] = true;
				else if (dp[i] < 0) dirs[i] = true;
			}
			// choose a direction
			var nDirs:int = 0;
			var gotLast:Boolean = false;
			var mDir:int;
			for (i = 0; i < 4; i++) {
				if (dirs[i]) {
					if (i == moveDir) gotLast = true;
					else mDir = i;
					nDirs += int(dirs[i]);
				}
			}
			if (!(nDirs == 1 || (nDirs == 2 && gotLast))) {
				// multiple directions: don't move
				isMoving = false;
				return;
			}
			if (gotLast && nDirs == 1) mDir = moveDir;

			// check whether to move
			if (isMoving && mDir == dir) {
				moveCounter -= 1;
			} else {
				isMoving = true;
				moveCounter = Conf.moveDelay;
			}
			if (mDir != dir) setDir(mDir);
			if (moveCounter > 0) return;
			moveDir = mDir;

			// boundary detection
			i = dir % 2; // axis
			j = (dir >= 2) ? 1 : -1; // direction on this axis
			if (pos[i] + j == int(j == 1) * (Conf.carpetSize[i] - 1) + j) {
				return;
			}
			// move
			var blockToMove:Block = null;
			var blockingBlock:Block = null;
			if (grabbedBlock !== null) {
				blockToMove = grabbedBlock;
				blockingBlock = carpet.blockInDir(pos, dir);
			} else {
				blockingBlock = blockToMove = carpet.blockInDir(pos, dir);
			}
			if (blockingBlock !== null && blockingBlock !== blockToMove) {
				// there's a block in the way that we're not moving
				return;
			}
			if (blockToMove !== null) {
				// moving a block: check if it can move
				var bPos:Array = carpet.tileInDir(blockToMove.pos, dir);
				if (bPos[0] < 1 || bPos[0] >= Conf.carpetSize[0] - 1 ||
					bPos[1] < 1 || bPos[1] >= Conf.carpetSize[1] - 1) {
					// block would move off screen
					return
				}
				blockingBlock = carpet.blockInTile(bPos);
				if (blockingBlock !== null && blockingBlock !== this) {
					// there's another block in its way
					return;
				}
			}
			canMove = false;
			carpet.moveInDir(this, dir, moveDone);
			if (blockToMove !== null) {
				carpet.moveInDir(blockToMove, dir, blockToMove.moveDone);
			}
		}
	}
}
