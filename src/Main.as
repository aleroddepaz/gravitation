package
{
	import game.Gravitation;
	import nl.jorisdormans.phantom2D.core.PhantomGame;
	
	public class Main extends PhantomGame
	{
		public function Main()
		{
			super(800, 600);
			addScreen(new Gravitation(1000, 800));
		}
	}
}