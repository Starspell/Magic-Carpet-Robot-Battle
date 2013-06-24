package
{
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.utils.Dictionary;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.FP;
	
	public class CarpetEntity extends Entity
	{
		[Embed(source = '../assets/sprites/carpetentity.png')] private const CARPET:Class;
		
		// Sounds
		[Embed(source = '../assets/audio/fireball1.mp3')] private const FIRE1:Class;
		[Embed(source = '../assets/audio/fireball2.mp3')] private const FIRE2:Class;
		[Embed(source = '../assets/audio/fireball3.mp3')] private const FIRE3:Class;
		[Embed(source = '../assets/audio/fireball4.mp3')] private const FIRE4:Class;
		[Embed(source = '../assets/audio/fireball5.mp3')] private const FIRE5:Class;
		[Embed(source = '../assets/audio/jetsound.mp3')] private const JET:Class;
		[Embed(source = '../assets/audio/boing.mp3')] private const BOUNCE:Class;
		
		private var fireSoundsArr:Array = [];
		private var jetSound:Sfx = new Sfx(JET);
		private var bounceSound:Sfx = new Sfx(BOUNCE);
		
		private var a:Number = 0; //The angle carpet is facing in radians ACW from +ve X axis.
		
		private var velA:Number = 0; //Angular velocity.
		private var acnA:Number = 0; //Angular acceleration.
		
		private var velX:Number = 0;
		private var velY:Number = 0;
		
		private var acnX:Number = 0;
		private var acnY:Number = 0;
		
		private var blocks:Object;
		
		private var image:Image;
		
		private var fireCounter:int = 0;
		
		public function CarpetEntity(blocks:Object, x:int, y:int, img:Image)
		{
			this.blocks = blocks;
			//image = new Image(CARPET);
			image = img;
			a = Math.PI / 2
			image.scaleX = 40 / 320;
			image.scaleY = 60 / 480;
			image.originX = 160;
			image.originY = 240;
			super(x, y, image);
			setHitbox(60, 60, 30, 30);
			layer = -2;
			
			type = "carpet";
			
			fireSoundsArr.push(new Sfx(FIRE1));
			fireSoundsArr.push(new Sfx(FIRE2));
			fireSoundsArr.push(new Sfx(FIRE3));
			fireSoundsArr.push(new Sfx(FIRE4));
			fireSoundsArr.push(new Sfx(FIRE5));
		}
		
		override public function update():void
		{
			var netForceX:Number = 0;
			var netForceY:Number = 0;

			var netMoment:Number = 0;
			
			var dist:Number;
			
			var isFlaring:Boolean = false;
			
			//Handle thrusters.
			for each (var thruster:Thruster in blocks.thruster)
			{
				if (thruster.on)
				{
					isFlaring = true;
					
					var thrusterAngle:Number;
					
					switch(thruster.dir)
					{
						case Conf.up:
							thrusterAngle = a;
							dist = - ((thruster.pos[0] + 0.5) - (Conf.carpetSize[0] / 2));
							break;
						case Conf.left:
							thrusterAngle = a - (Math.PI / 2);
							dist = (thruster.pos[1] + 0.5) - (Conf.carpetSize[1] / 2);
							break;
						case Conf.down:
							thrusterAngle = a + Math.PI;
							dist = (thruster.pos[0] + 0.5) - (Conf.carpetSize[0] / 2);
							break;
						case Conf.right:
							thrusterAngle = a + (Math.PI / 2);
							dist = -((thruster.pos[1] + 0.5) - (Conf.carpetSize[1] / 2));
							break;
					}
					
					// Sort out force.
					netForceX -= Math.cos(thrusterAngle) * Conf.thrusterForce;
					netForceY -= Math.sin(thrusterAngle) * Conf.thrusterForce;
					
					// Sort out moment.
					netMoment += dist * Conf.thrusterForce;
				}
			}
			
			if ( isFlaring && !jetSound.playing ) jetSound.loop(0.25);
			else if ( !isFlaring ) jetSound.stop();
			
			// Friction.
			netForceX -= velX * Conf.carpetFriction;
			netForceY -= velY * Conf.carpetFriction;
			
			netMoment -= velA * velA * Conf.carpetRotFriction;
			
			acnX = netForceX / Conf.carpetMass;
			acnY = netForceY / Conf.carpetMass;
			
			acnA = netMoment / Conf.carpetMOI;
			
			velX += acnX;
			velY += acnY;
			velA += acnA;
			
			// Smoothly moves very low speed to 0.
			velA *= 0.99;
			velX *= 0.99;
			velY *= 0.99;
			
			a -= velA;
			
			moveBy( -velX, -velY, "buoy");
			
			image.angle = 90 - Conf.radiansToDegrees(a);
			
			//Handle firing bullets.
			--fireCounter;
			if(fireCounter <= 0) 
			{
				for each (var cannon:Cannon in blocks.cannon)
				{
					if(cannon._on)
						fire(cannon.pos[0], cannon.pos[1], cannon.dir);
				}
				fireCounter = Conf.cannonFireInterval;
			}
			
			//var g:Gate = this.world.getNextGate();
			
			var arr:Array = [];
			this.world.getClass(Gate, arr);
			for each( var g:Gate in arr )
			{
				var toGate:Point = new Point(this.x - g.midX, this.y - g.midY);
				var gateDist:Number = toGate.x * g.norm.x + toGate.y * g.norm.y;
				var gateParllDist:Number = toGate.x * g.tang.x + toGate.y * g.tang.y;
				if (Math.abs(gateDist) < Conf.gateCollideDist && Math.abs(gateParllDist) < g.halfLength)
				{
					// Passed through the gate
					g.pass();
				}
			}
			
			var tempLevel:Level = this.world as Level;
			
			if (tempLevel)
			{
				var topLeft:Point = tempLevel.worldBoundaryCoords[0];
				var bottomRight:Point = tempLevel.worldBoundaryCoords[1];
				
				if (left < topLeft.x || right > bottomRight.x) { velX = - velX * Conf.edgeRepel; playBounce(); }
				if (top < topLeft.y || bottom > bottomRight.y) { velY = - velY * Conf.edgeRepel; playBounce(); }
				
				this.world.camera.x = Math.max(
					topLeft.x, Math.min(
						bottomRight.x - Conf.screenSize[0],
						x - ((Conf.screenSize[0] / 2) + 175)
					)
				);
				this.world.camera.y = Math.max(
					topLeft.y, Math.min(
						bottomRight.y - Conf.screenSize[1],
						y - (Conf.screenSize[1] / 2)
					)
				);
			}
		}
		
		private function playBounce():void
		{
			if( !bounceSound.playing ) bounceSound.play();
		}
		
		override public function moveCollideX(e:Entity):Boolean
		{
			if (e.type == "buoy")
				velX = -velX * Conf.buoyRepel;
				playBounce();
			return true;
		}
		
		override public function moveCollideY(e:Entity):Boolean
		{
			if (e.type == "buoy")
				velY = -velY * Conf.buoyRepel;
				playBounce();
			return true;
		}
		
		// Fire a bullet from a cannon at carpetx,carpetY on carpet, in direction dir.
		public function fire(carpetX:int, carpetY:int, dir:int):void
		{
			var scaledX:Number = 5 * (carpetX + 0.5 - (Conf.carpetSize[0] / 2));
			var scaledY:Number =  5 * (carpetY + 0.5 - (Conf.carpetSize[1] / 2));
			
			var cannonA:Number = a - (Math.PI / 2);
			
			var rotatedX:Number = scaledX * Math.cos(cannonA) - scaledY * Math.sin(cannonA);
			var rotatedY:Number = scaledX * Math.sin(cannonA) + scaledY * Math.cos(cannonA);

			var bulletA:Number;
			
			switch(dir)
			{
				case Conf.up:
					bulletA = a;
					break;
				case Conf.right:
					bulletA = a + (Math.PI / 2);
					break;
				case Conf.down:
					bulletA = a + Math.PI;
					break;
				case Conf.left:
					bulletA = a - (Math.PI / 2);
					break;
			}
			this.world.add(new Bullet(Conf.bulletSpeed * Math.cos(bulletA + Math.PI) + velX,
				Conf.bulletSpeed * Math.sin(bulletA + Math.PI) + velY,
				this.x + rotatedX, this.y + rotatedY));
				
			// Play a firing sound
			var soundIndex:int = FP.rand(fireSoundsArr.length);
			fireSoundsArr[soundIndex].play(0.5);
		}

		override public function render():void {
			image.updateBuffer();
			super.render();
		}
	}
}
