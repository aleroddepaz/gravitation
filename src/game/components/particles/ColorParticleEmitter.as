package game.components.particles 
{
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.core.Phantom;
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
		
		override public function generateXML():XML 
		{
			var xml:XML = super.generateXML();
			xml.@timer = timer;
			xml.@color = color;
			xml.@delay = delay;
			xml.@life = life;
			xml.@randomLife = randomLife;
			xml.@randomPosition = randomPosition;
			xml.@randomVelocity = randomVelocity;
			xml.@speedFactor = speedFactor;
			return xml;
		}
		
		override public function readXML(xml:XML):void 
		{
			super.readXML(xml);
			if (xml.@timer.length() > 0) timer = xml.@timer;
			if (xml.@color.length() > 0) color = xml.@color;
			if (xml.@delay.length() > 0) delay = xml.@delay;
			if (xml.@life.length() > 0) life = xml.@life;
			if (xml.@randomLife.length() > 0) randomLife = xml.@randomLife;
			if (xml.@randomPosition.length() > 0) randomPosition = xml.@randomPosition;
			if (xml.@randomVelocity.length() > 0) randomVelocity = xml.@randomVelocity;
			if (xml.@speedFactor.length() > 0) speedFactor = xml.@speedFactor;
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