package
{
	import game.Gravitation;
	import nl.jorisdormans.phantom2D.core.PhantomGame;
	import nl.jorisdormans.phantom2D.core.Screen;
	import nl.jorisdormans.phantom2D.layers.Background;
	
	public class Main extends PhantomGame
	{
		public function Main()
		{
			super(800, 600);
			addScreen(new Gravitation(1000, 1000, 0));
		}
	}
}