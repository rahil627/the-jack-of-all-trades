package {
	import flash.display.Stage;
	public class BusinessMan extends Enemy {
		[Embed(source = "images/Man8 (Front).gif")]
		private const image:Class;
		
		public function BusinessMan(stageRef:Stage):void {
			super(stageRef);//calls the base constructor
			this.moveSpeed = 4;
			this.direction = -1;
			this.hitPoints = 1;
			
			bitmap = new image();
			bitmap.height = 44;
			bitmap.width = 32;
			this.addChild(bitmap);
		}
	}
}