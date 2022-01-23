package {
	import flash.display.Stage;
	public class Doppelganger extends Enemy {
		[Embed(source = "images/Ness (Front).gif")]
		private const image:Class;
		
		public function Doppelganger(stageRef:Stage):void {
			super(stageRef);//calls the base constructor
			this.moveSpeed = 2.5;
			this.direction = 1;
			this.hitPoints = 99999999;
			
			bitmap = new image();
			bitmap.height = 25;
			bitmap.width = 20;
			
			this.addChild(bitmap);
		}
	}
}