package {
	import flash.display.Stage;
	public class Mother extends Enemy {
		[Embed(source = "images/Old Woman (Front).gif")]
		private const image:Class;
		
		public function Mother(stageRef:Stage):void {
			super(stageRef);//calls the base constructor
			this.moveSpeed = 2.5;
			this.direction = 1;
			this.hitPoints = 99999999;
			
			bitmap = new image();
			
			this.addChild(bitmap);
		}
	}
}