package {
	import flash.display.Stage;
	public class Professor extends Enemy {
		[Embed(source = "images/Dr Andonuts (Front).gif")]
		private const image:Class;
		
		public function Professor(stageRef:Stage):void {
			super(stageRef);//calls the base constructor
			this.moveSpeed = 4;
			this.direction = -1;
			this.hitPoints = 1;
			
			bitmap = new image();
			bitmap.width = 32;
			bitmap.height = 46;			
			this.addChild(bitmap);
		}
	}
}