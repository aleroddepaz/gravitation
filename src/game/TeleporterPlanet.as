package game 
{
	import game.components.Teleporter;
	import game.components.AtmosphereParticleEmitter;
	
	public class TeleporterPlanet extends Planet 
	{
		public function TeleporterPlanet(radius:uint = 32)
		{
			super(radius, true);
			addComponent(new Teleporter());
		}
		
		protected override function setAtmosphere():void
		{
			addComponent(new AtmosphereParticleEmitter(this.radius * 3, 0xff0000));
		}
	}

}