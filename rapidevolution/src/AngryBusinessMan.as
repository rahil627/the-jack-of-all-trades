package {
	import flash.display.Stage;
	public class AngryBusinessMan extends Enemy {
		[Embed(source = "images/Annoying Reveler.gif")]
		private const image:Class;
		
		public function AngryBusinessMan(stageRef:Stage):void {
			super(stageRef);//calls the base constructor
			this.moveSpeed = 6;
			this.direction = -1;
			this.hitPoints = 6;
			
			bitmap = new image();
			bitmap.height = 54;
			bitmap.width = 32;
			this.addChild(bitmap);
		}
	}
}