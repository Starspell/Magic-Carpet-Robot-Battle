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
			var bc:Array = (world as Level).worldBoundaryCoords;
			var c:int = 0xFfFffF;
			Draw.linePlus( bc[0].x, bc[0].y, bc[1].x, bc[0].y, c, 1, 5);
			Draw.linePlus( bc[1].x, bc[0].y, bc[1].x, bc[1].y, c, 1, 5);
			Draw.linePlus( bc[1].x, bc[1].y, bc[0].x, bc[1].y, c, 1, 5);
			Draw.linePlus( bc[0].x, bc[1].y, bc[0].x, bc[0].y, c, 1, 5);
			for each (var linePts:Array in pts) {
				var i:int;
				for (i = 0; i < linePts.length - 1; i++) {
					Draw.linePlus(
						linePts[i][0], linePts[i][1], linePts[i + 1][0],
						linePts[i + 1][1], c, .3
					);
				}
			}
		}
    }
}
