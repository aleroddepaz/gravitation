package game.gameobjects
{
	import flash.geom.Vector3D;
	import game.components.particles.ColorParticleEmitter;
	import game.components.particles.ExplodeOnDestroy;
	import game.components.RotateAround;
	import game.components.audio.SfxrSound;
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.Mover;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	
	public class Pickup extends GameObject
	{
		protected var target:GameObject;
		private static const pickupColor:uint = 0xffffff;
		private static const pickupSound:String = "2,,0.0343,,0.4288,0.4971,,0.2291,,,,,,,,0.4649,,,1,,,,,0.5";
		
		public function Pickup(target:GameObject)
		{
			this.mass = 0;
			this.target = target;
			this.addColorComponents();
			addComponent(new BoundingCircle(8));
			addComponent(new Mover(new Vector3D(0, 0), 0, 0, true));
			addComponent(new RotateAround(50));
			addComponent(new SfxrSound("pickupSound", Pickup.pickupSound));
		}
		
		public function addColorComponents():void
		{
			addComponent(new BoundingShapeRenderer(Pickup.pickupColor));
			addComponent(new ColorParticleEmitter(Pickup.pickupColor, 8, 1, 0, 0.4, 5, 0.5));
			addComponent(new ExplodeOnDestroy(Pickup.pickupColor));
		}
		
		override public function initialize():void 
		{
			super.initialize();
			handleMessage("rotate", target);
		}
		
		override public function afterCollisionWith(other:GameObject):void
		{
			if (other is Player)
			{
				var game:Main = objectLayer.screen.game as Main;
				game.updateProgress();
				handleMessage("pickupSound");
				handleMessage("destroy");
			}
		}
	}
}