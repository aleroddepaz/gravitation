package game.gameobjects
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import game.components.audio.SfxrSound;
	import game.components.RotateAround;
	import game.Gravitation;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	
	/**
	 * Respawn point 
	 */
	public class Checkpoint extends GameObject
	{
		private static const respawnSound:String = "0,0.0088,0.01,0.0124,0.6623,0.5012,,0.4863,0.0002,,0.9072,-0.478,0.1065,0.4206,-0.0296,0.1406,0.0805,0.0761,0.7526,,-0.9351,0.1603,-0.0401,0.5";
		private var target:Planet;
		
		public function Checkpoint(target:Planet) 
		{
			this.target = target;
			addComponent(new RotateAround(0));
			addComponent(new SfxrSound("respawnSound", respawnSound));
		}
		
		override public function initialize():void 
		{
			super.initialize();
			handleMessage("rotate", { target: target } );
			var player:Player = new Player(this);
			objectLayer.addGameObject(Gravitation.player = player, position);
		}
		
		public function getRespawnPlanet():Planet
		{
			return target;
		}

		public function respawnPlayer():void
		{
			var timer:Timer = new Timer(2000, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, createNewPlayer);
			timer.start();
		}
		
		private function createNewPlayer(event:TimerEvent = null):void
		{
			var player:Player = new Player(this);
			objectLayer.addGameObject(Gravitation.player = player, position);
			handleMessage("respawnSound");
		}
	}
}
