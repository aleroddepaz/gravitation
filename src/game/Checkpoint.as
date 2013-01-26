package game
{
	import flash.events.TimerEvent;
	import flash.geom.Vector3D;
	import flash.utils.Timer;
	import game.components.RotateAround;
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	
	public class Checkpoint extends GameObject
	{
		private var target:Planet;
		
		public function Checkpoint(respawnPlanet:Planet) 
		{
			this.target = respawnPlanet;
			addComponent(new RotateAround(100));
		}
		
		override public function initialize():void 
		{
			super.initialize();
			handleMessage("rotate", this.target);
			createNewPlayer();
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
			objectLayer.addGameObject(player, position);
			objectLayer.screen.camera.handleMessage("followObject", {followObject : player});
		}
	}
}
