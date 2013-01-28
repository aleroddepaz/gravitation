package game.components
{
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	import nl.jorisdormans.phantom2D.particles.Particle;
	import nl.jorisdormans.phantom2D.particles.ParticleLayer;
	
	public class AtmosphereParticleEmitter extends GameObjectComponent
	{
		private var distance:Number;
		private var color:uint;
		
		public function AtmosphereParticleEmitter(distance:Number, color:uint)
		{
			this.distance = distance;
			this.color = color;
		}
		
		override public function generateXML():XML 
		{
			var xml:XML = super.generateXML();
			xml.@distance = distance;
			xml.@color = color;
			return xml;
		}
		
		override public function readXML(xml:XML):void 
		{
			super.readXML(xml);
			if (xml.@distance.length() > 0) distance = xml.@distance;
			if (xml.@color.length() > 0) color = xml.@color;
		}
		
		override public function update(elapsedTime:Number):void
		{
			var particleLayer:ParticleLayer = gameObject.objectLayer.screen.getComponentByClass(ParticleLayer) as ParticleLayer;
			if (!particleLayer)
			{
				return;
			}
			
			var angle:Number = 0;
			while (angle < Math.PI * 2)
			{
				angle += Math.random() * 2 + 1;
				var particle:Particle = new Particle();
				var life:Number = 0.25 + (Math.random() - Math.random()) * 0.2;
				var position:Vector3D = gameObject.position.clone();
				position.x += Math.cos(angle) * distance;
				position.y += Math.sin(angle) * distance;
				particle.initialize(life, position, new Vector3D(0, 0, 0));
				particle.color = this.color;
				particleLayer.addParticle(particle);
			}
		}
	}

}