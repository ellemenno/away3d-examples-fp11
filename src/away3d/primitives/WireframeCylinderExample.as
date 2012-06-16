package away3d.primitives
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;

	import away3d.cameras.Camera3D;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;


	[SWF(backgroundColor="#000000", frameRate="30", quality="LOW")]
	public class WireframeCylinderExample extends Sprite
	{

		protected var view:View3D;
		protected var geo:ObjectContainer3D;
		protected var lastTime:int;


		public function WireframeCylinderExample()
		{
			super();

			// create a viewport and add it to the stage
			view = new View3D();
			view.backgroundColor = 0x2a2a2a;
			addChild(view);

			// add geometry to the scene
			geo = createGeo();
			view.scene.addChild(geo);

			// set the camera and object for a good view
			const cam:Camera3D = view.camera;
			cam.y = 60;
			cam.z = -200;
			cam.lookAt(geo.position);
			geo.rotationY = -15;

			// add debug stats
			const stats:DisplayObject = addChild(new AwayStats(view));
			stats.x = stage.stageWidth - stats.width;
			stats.y = 0;

			// listen for enterframe to to render updates
			addEventListener(Event.ENTER_FRAME, update);
		}

		protected function createGeo():ObjectContainer3D
		{
			const geometry:WireframeCylinder = new WireframeCylinder();
			return geometry;
		}

		protected function get elapsed():Number
		{
			const now:int = getTimer();
			const value:Number = (lastTime ? (now - lastTime) : now) * .001; // seconds elapsed
			lastTime = now;
			return value;
		}

		protected function update(e:Event):void
		{
			const s:Number = elapsed;

			// apply rotations and render
			geo.rotationX += 7 * s; // degrees per second
			geo.rotationY += 12 * s; // degrees per second

			view.render();
		}
	}
}