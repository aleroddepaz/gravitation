package game
{
	import flash.geom.Vector3D;
	import game.components.ColorParticleEmitter;
	import game.components.ExplodeOnDestroy;
	import game.components.RotateAround;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	
	public class ShieldPickup extends Pickup
	{
		private static const pickupColor:uint = 0x3333ff;
		
		public function ShieldPickup(target:GameObject)
		{
			super(target);
		}
		
		override public function addColorComponents():void
		{
			addComponent(new BoundingShapeRenderer(ShieldPickup.pickupColor));
			addComponent(new ColorParticleEmitter(ShieldPickup.pickupColor, 8, 0, 1, 0, 0.4, 5, 0.5));
			addComponent(new ExplodeOnDestroy(ShieldPickup.pickupColor));
		}
		
		override public function afterCollisionWith(other:GameObject):void
		{
			if (other is Player)
			{
				other.handleMessage("shield");
			}
			super.afterCollisionWith(other);
		}
	}
}