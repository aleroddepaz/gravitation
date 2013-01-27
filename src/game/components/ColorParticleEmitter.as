package game.components 
{
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	import nl.jorisdormans.phantom2D.particles.Particle;
	import nl.jorisdormans.phantom2D.particles.ParticleLayer;
	
	public class ColorParticleEmitter extends GameObjectComponent 
	{
		private var color:uint;
		private var speedFactor:Number;
		private var randomVelocity:Number;
		private var randomPosition:Number;
		private var life:Number;
		private var randomLife:Number;
		private var particleType:Class;
		private var timer:Number;
		private var delay:Number;
		private var layer:int;
		private var particleLayer:ParticleLayer;
		
		public function ColorParticleEmitter(color:uint, frequency:Number = 10, layer:int = 0, life:Number = 1, randomLife:Number = 0, randomPosition:Number = 0, randomVelocity:Number = 0, speedFactor:Number = 1) 
		{
			this.timer = 0;
			this.color = color;
			this.delay = 1/frequency;
			this.life = life;
			this.randomLife = randomLife;
			this.randomPosition = randomPosition;
			this.randomVelocity = randomVelocity;
			this.speedFactor = speedFactor;
			this.layer = layer;
		}
		
		override public function update(elapsedTime:Number):void 
		{
			timer -= elapsedTime;
			if (timer < 0) {
				if (!particleLayer) {
					particleLayer = gameObject.objectLayer.screen.getComponentByClass(ParticleLayer, layer) as ParticleLayer;
					if (!particleLayer) {
						return;
					}
				}
				timer += delay;
				var particle:Particle = new Particle();
				if (particle) {
					var l:Number = life + (Math.random() - Math.random()) * randomLife;
					var p:Vector3D = gameObject.position.clone();
					p.x += randomPosition * (Math.random() - Math.random());
					p.y += randomPosition * (Math.random() - Math.random());
					var v:Vector3D = new Vector3D();
					if (gameObject.mover) {
						v.x += gameObject.mover.velocity.x * speedFactor;
						v.y += gameObject.mover.velocity.y * speedFactor;
					}
					v.x += randomVelocity * (Math.random() - Math.random());
					v.y += randomVelocity * (Math.random() - Math.random());
					particle.initialize(l, p, v);
					particle.color = color;
					particleLayer.addParticle(particle);
				}
			}
			
		}
		
	}

}