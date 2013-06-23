package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;

	public class GuideLines extends Entity
	{
		private var pts:Array;

		public function GuideLines(pts:Array)
		{
			this.pts = pts;
			super();
		}

		public override function render():void {
			for each (var linePts:Array in pts) {
				var i:int;
				for (i = 0; i < linePts.length - 1; i++) {
					Draw.linePlus(
						linePts[i][0], linePts[i][1], linePts[i + 1][0],
						linePts[i + 1][1], 0xFfFffF, .3
					);
				}
			}
		}
    }
}
