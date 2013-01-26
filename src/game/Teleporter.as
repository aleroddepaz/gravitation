package game 
{
	import game.components.Teleport;
	import game.components.AtmosphereParticleEmitter;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	
	public class Teleporter extends Planet 
	{
		private static const atmosphereColor:uint = 0xff5555;
		
		public function Teleporter(target:GameObject, radius:uint = 32)
		{
			super(target, radius, true);
			addComponent(new Teleport());
		}
		
		override public function addAtmosphere():void
		{
			trace("Red!");
			addComponent(new AtmosphereParticleEmitter(getAtmosphereRadius(), Teleporter.atmosphereColor));
		}
	}

}