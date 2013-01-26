package game
{
	import flash.geom.Vector3D;
	import game.components.AtmosphereParticleEmitter;
	import game.components.RotateAround;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.Mover;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	
	public class Planet extends GameObject
	{
		private static const planetColor:uint = 0x555555;
		private static const atmosphereColor:uint = 0x555555;
		
		private var radius:uint;
		private var target:GameObject;
		private var hasAtmosphere:Boolean;
		
		public function Planet(target:GameObject, radius:uint = 32, hasAtmosphere:Boolean = true)
		{
			this.radius = radius;
			this.target = target;
			this.hasAtmosphere = hasAtmosphere;
			addComponent(new BoundingCircle(radius));
			addComponent(new BoundingShapeRenderer(Planet.planetColor));
			addComponent(new Mover(new Vector3D(0, 0), 10, 5));
			addComponent(new RotateAround(5));
			if (this.hasAtmosphere)
			{
				addComponent(new AtmosphereParticleEmitter(getAtmosphereRadius(), Planet.atmosphereColor));
			}
		}
		
		override public function initialize():void 
		{
			super.initialize();
			handleMessage("rotate", this.target);
		}
		
		public function getRadius():uint
		{
			return radius;
		}
		
		public function getAtmosphereRadius():uint
		{
			return radius * 3;
		}
		
		public function isCloseTo(playerPosition:Vector3D):Boolean
		{
			var distance:Number = Math.abs(Vector3D.distance(position, playerPosition));
			return hasAtmosphere && distance < getAtmosphereRadius();
		}
	}
}
