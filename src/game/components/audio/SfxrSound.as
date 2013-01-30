package game.components.audio 
{
	import nl.jorisdormans.phantom2D.core.Phantom;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	import nl.jorisdormans.phantom2D.thirdparty.sfxr.SfxrSynth;
	
	/**
	 * nl.jorisdormans.phantom2D.audio.SfxrSound does not work!!
	 */
	public class SfxrSound extends GameObjectComponent 
	{
		private var message:String;
		private var synth:SfxrSynth;
		
		public function SfxrSound(message:String, settingsString:String)
		{
			this.message = message;
			this.synth = new SfxrSynth();
			synth.params.setSettingsString(settingsString);
			synth.cacheSound();
		}
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int
		{
			if (this.message == message)
			{
				synth.play();
				return Phantom.MESSAGE_HANDLED;
			}
			return super.handleMessage(message, data);
		}
	
	}

}