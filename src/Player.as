package
{
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
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
		private var movingDir:int;
		private var grabbedBlock:InanimateBlock;

		[Embed(source = '../assets/sprites/player.png')] private const IMG:Class;
		
		// Sounds
		[Embed(source = '../assets/audio/blockmove1.mp3')] private const BLOCK1:Class;
		[Embed(source = '../assets/audio/blockmove2.mp3')] private const BLOCK2:Class;
		[Embed(source = '../assets/audio/blockmove3.mp3')] private const BLOCK3:Class;
		[Embed(source = '../assets/audio/blockmove4.mp3')] private const BLOCK4:Class;
		[Embed(source = '../assets/audio/blockmove5.mp3')] private const BLOCK5:Class;
		[Embed(source = '../assets/audio/clang.mp3')] private const GRAB:Class;
		
		private var blockSoundsArr:Array = [];
		private var grabSound:Sfx = new Sfx(GRAB);

		public function Player(carpet:CarpetWorld, x:int, y:int, pID:int)
		{
			super(carpet, x, y);
			sprite = new Spritemap(IMG, 40, 40);
			graphic = sprite;
			setDir(Conf.up);
			if (pID < Conf.playerData.length) {
				sprite.color = Conf.playerData[pID][0];
				moveKeys = Conf.playerData[pID][1].move;
				var args:Array = Conf.playerData[pID][1].grab.slice();
				args.unshift("grab" + pID);
				Input.define.apply(null, args);
				grabKey = "grab" + pID;
			} else {
				throw new Error("no configuration for player ID " + pID);
			}
			movingDir = moveDir = dir;
			
			blockSoundsArr.push(new Sfx(BLOCK1));
			blockSoundsArr.push(new Sfx(BLOCK2));
			blockSoundsArr.push(new Sfx(BLOCK3));
			blockSoundsArr.push(new Sfx(BLOCK4));
			blockSoundsArr.push(new Sfx(BLOCK5));
		}

		private function setDir(dir:int):void {
			this.dir = dir;
			sprite.setFrame(dir, int(grabbedBlock != null));
		}

		private function checkKeys(ks:Object):int {
			var held:Boolean;
			if (ks is int) held = Input.check(ks as int);
			else {
				held = false;
				for each (var k:int in (ks as Array)) {
					held ||= Input.check(k);
				}
			}
			return int(held);
		}

		override public function update():void
		{
			if (!canMove) return;
			if (Input.pressed(grabKey)) {
				var b:Block = carpet.blockInDir(pos, dir);
				if (b !== null && b is InanimateBlock &&
					(b as InanimateBlock).grabber === null) {
					grabbedBlock = b as InanimateBlock;
					grabbedBlock.grabber = this;
					// Play grabbed sound
					grabSound.play(0.4);
				}
			}
			if (!Input.check(grabKey) && grabbedBlock !== null) {
				grabbedBlock.grabber = null;
				grabbedBlock = null;
			}
			
			sprite.setFrame(dir, int(grabbedBlock !== null));

			var i:int, j:int;
			// determine input directions
			var dp:Array = [0, 0];
			var dirs:Array = [false, false, false, false];
			for (i = 0; i < 2; i++) {
				dp[i] = (checkKeys(moveKeys[i + 2]) - checkKeys(moveKeys[i]));
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
			if (!(nDirs == 1 || nDirs == 2)) {
				// multiple directions: don't move
				isMoving = false;
				return;
			}
			if (gotLast && nDirs == 1) mDir = moveDir;

			// check whether to move
			if (isMoving && mDir == movingDir) {
				moveCounter -= 1;
			} else {
				if (!isMoving && grabbedBlock !== null) moveCounter = 0;
				else moveCounter = Conf.moveDelay;
				isMoving = true;
			}
			movingDir = mDir;
			if (mDir != dir && grabbedBlock === null) setDir(mDir);
			if (moveCounter > 0) return;
			moveDir = mDir;

			// boundary detection
			i = movingDir % 2; // axis
			j = (movingDir >= 2) ? 1 : -1; // direction on this axis
			if (pos[i] + j == int(j == 1) * (Conf.carpetSize[i] - 1) + j) {
				return;
			}
			// move
			var blockToMove:Block = null;
			var blockingBlock:Block = null;
			if (grabbedBlock !== null) {
				blockToMove = grabbedBlock;
				blockingBlock = carpet.blockInDir(pos, movingDir);
			} else {
				blockingBlock = blockToMove = carpet.blockInDir(pos, movingDir);
			}
			if (blockingBlock !== null && blockingBlock !== blockToMove) {
				// there's a block in the way that we're not moving
				return;
			}
			if (blockToMove !== null) {
				// moving a block: check if it can move
				var bPos:Array = carpet.tileInDir(blockToMove.pos, movingDir);
				if (!(blockToMove is InanimateBlock)) {
					// can't move player
					return;
				}
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
				if ((blockToMove as InanimateBlock).grabber !== this &&
					(blockToMove as InanimateBlock).grabber !== null)
					// another player is grabbing this block
					return;
			}
			canMove = false;
			carpet.moveInDir(this, movingDir, moveDone);
			if (blockToMove !== null) {
				carpet.moveInDir(blockToMove, movingDir, blockToMove.moveDone);
				// Play a moving sound
				var soundIndex:int = FP.rand(blockSoundsArr.length);
				blockSoundsArr[soundIndex].play();
			}
		}
	}
}
