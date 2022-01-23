package {
	import flash.display.Stage;
	public class Magnate extends Enemy {
		[Embed(source = "images/Poochyfud (Front).gif")]
		private const image:Class;
		
		public function Magnate(stageRef:Stage):void {
			super(stageRef);//calls the base constructor
			this.moveSpeed = 0;
			this.direction = -1;
			this.hitPoints = 400;
			
			bitmap = new image();
			bitmap.width = 32;
			bitmap.height = 48;
			this.addChild(bitmap);
		}
	}
}