package game 
{
	import flash.events.TimerEvent;
	import flash.geom.Vector3D;
	import flash.utils.Timer;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	
	public class Checkpoint extends GameObject 
	{
		protected var respawnPlanet:GameObject;
		
		public function Checkpoint(respawnPlanet:GameObject) 
		{
			this.respawnPlanet = respawnPlanet;
		}
		
		public function respawnPlayer():void
		{
			var timer:Timer = new Timer(2000, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, _foo);
			timer.start();
		}
		
		private function _foo(event:TimerEvent):void
		{
			var player:Player = new Player(this);
			var respawnPosition:Vector3D = respawnPlanet.position.clone();
			respawnPosition.x -= 50;
			respawnPosition.y -= 50;
			this.objectLayer.addGameObject(player, respawnPosition);
			player.handleMessage("rotate", respawnPlanet);
		}
	}
}