package
{
	import flash.events.*;
	import flash.utils.*;
	import game.*;
	import nl.jorisdormans.phantom2D.core.*;
	
	public class Main extends PhantomGame
	{
		private static var pickupsCollected:Number = 0;
		private static var totalPickups:Number = 0;
		
		/**
		 * Actual level that is going to be loaded
		 * (Change this value to manually select the initial level)
		 */
		private var currentLevel:int = 0;
		
		public function Main()
		{
			super(800, 600);
			addScreen(new Gravitation(currentLevel));
		}
		
		public function updateProgress():void
		{
			pickupsCollected++;
			if (pickupsCollected == totalPickups)
			{
				var timer:Timer = new Timer(1000, 1);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, loadNewLevel);
				timer.start();
			}
		}
		
		private function loadNewLevel(event:TimerEvent):void
		{
			if (currentLevel < 9)
			{
				pickupsCollected = 0;
				totalPickups = 0;
				removeCurrentScreen();
				addScreen(new Gravitation(++currentLevel));
			}
		}
		
		public static function getProgress():Number
		{
			if (totalPickups == 0) return 0;
			return pickupsCollected / totalPickups;
		}
		
		public static function incrementTotalPickups():void
		{
			totalPickups++;
		}
	}
}