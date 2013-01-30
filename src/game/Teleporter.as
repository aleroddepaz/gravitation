package game 
{
	import game.components.SfxrSound;
	import game.components.Teleport;
	import game.components.AtmosphereParticleEmitter;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	
	public class Teleporter extends Planet 
	{
		private static const atmosphereColor:uint = 0x33ff33;
		private static const teleportSound:String = "0,,0.2944,,0.4209,0.2006,,0.2484,,,,,,0.0393,,,,,1,,,,,0.5";
		
		public function Teleporter(destination:GameObject, target:GameObject, radius:uint = 32)
		{
			super(target, radius, true);
			addComponent(new Teleport(destination));
			addComponent(new SfxrSound("teleportSound", Teleporter.teleportSound));
		}
		
		override public function addAtmosphere():void
		{
			addComponent(new AtmosphereParticleEmitter(getAtmosphereRadius(), Teleporter.atmosphereColor));
		}
		
	}

}