package game.components
{
	import game.gameobjects.Player;
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.core.Phantom;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	import nl.jorisdormans.phantom2D.thirdparty.sfxr.SfxrSynth;
	
	public class Teleport extends GameObjectComponent
	{
		private static const atmosphereColor:uint = 0xffffff;
		private static const teleportSound:String = "0,,0.2944,,0.4209,0.2006,,0.2484,,,,,,0.0393,,,,,1,,,,,0.5";
		
		private var destination:GameObject;
		private var synth:SfxrSynth;
		
		public function Teleport(destination:GameObject)
		{
			this.destination = destination;
			this.synth = new SfxrSynth();
			synth.params.setSettingsString(teleportSound);
			synth.cacheSound();
		}
		
		override public function onAdd(composite:Composite):void 
		{
			super.onAdd(composite);
			gameObject.handleMessage("setAtmosphereColor", { color: atmosphereColor } );
		}
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int
		{
			switch (message)
			{
				case "rotatingAround":
					if (data.player != null)
					{
						synth.play();
						teleport(data.player);
					}
					return Phantom.MESSAGE_HANDLED;
			}
			return super.handleMessage(message, data, componentClass);
		}
		
		private function teleport(player:GameObject):void
		{
			player.position = destination.position.clone().add(player.position.clone().subtract(gameObject.position));
			player.handleMessage("rotate", {target : destination});
		}
		
	}
}