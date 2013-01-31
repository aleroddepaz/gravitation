package
{
	import flash.events.*;
	import flash.utils.*;
	import game.*;
	import nl.jorisdormans.phantom2D.core.*;
	
	public class Main extends PhantomGame
	{
		
		private static var pickups:int = 0;
		private var currentLevel:int = 6;
		
		public function Main()
		{
			super(800, 600);
			addScreen(new Gravitation(currentLevel));
		}
		
		public static function incrementPickups():void
		{
			pickups++;
		}
		
		public function updateProgress():void
		{
			pickups--;
			if (pickups == 0)
			{
				var timer:Timer = new Timer(1000, 1);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, loadNewLevel);
				timer.start();
			}
		}
		
		private function loadNewLevel(event:TimerEvent):void
		{
			removeCurrentScreen();
			addScreen(new Gravitation(++currentLevel));
		}
	}
}