package {
	import flash.display.Stage;
	public class BadInfluenceMan extends Enemy {
		[Embed(source = "images/Hippie (Front).gif")]
		private const image:Class;
		
		public function BadInfluenceMan(stageRef:Stage):void {
			super(stageRef); //calls the base constructor
			this.moveSpeed = 6;
			this.direction = -1;
			this.hitPoints = 5;
			
			bitmap = new image();
			bitmap.height = 48;
			bitmap.width = 32;
			this.addChild(bitmap);
		}
	}
}