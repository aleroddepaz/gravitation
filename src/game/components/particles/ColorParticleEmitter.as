package game.components.particles 
{
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.core.Phantom;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	import nl.jorisdormans.phantom2D.particles.Particle;
	import nl.jorisdormans.phantom2D.particles.ParticleLayer;
	
	/**
	 * Refactored version of Phantom's ParticleEmitter with a color argument
	 * (nl.jorisdormans.phantom2D.particles.ParticleEmitter needs Particle subclasses
	 * even for plain particles with different color)
	 */
	public class ColorParticleEmitter extends GameObjectComponent 
	{
		protected var color:uint;
		protected var speedFactor:Number;
		protected var randomVelocity:Number;
		protected var randomPosition:Number;
		protected var life:Number;
		protected var randomLife:Number;
		protected var particleType:Class;
		protected var timer:Number;
		protected var delay:Number;
		protected var layer:int;
		protected var particleLayer:ParticleLayer;
		
		public function ColorParticleEmitter(color:uint, frequency:Number = 10, life:Number = 1, randomLife:Number = 0, randomPosition:Number = 0, randomVelocity:Number = 0, speedFactor:Number = 1) 
		{
			this.timer = 0;
			this.color = color;
			this.delay = 1/frequency;
			this.life = life;
			this.randomLife = randomLife;
			this.randomPosition = randomPosition;
			this.randomVelocity = randomVelocity;
			this.speedFactor = speedFactor;
		}
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int 
		{
			switch(message)
			{
				case "setParticleColor":
					if (data && data.color) this.color = data.color;
					return Phantom.MESSAGE_HANDLED;
			}
			return super.handleMessage(message, data, componentClass);
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
				// Change the color of a white particle
				particle.color = color;
				particleLayer.addParticle(particle);
			}
			
		}
		
	}

}