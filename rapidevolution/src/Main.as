/*
 * The game's levels encourages you to beat it in one path, but it isn't the right one, similar to how in a capitalist country, an individual may take the wrong path in life.
 * The problem goes further in that the character tries hard to become skilled in many crafts, but become a jack of all trades.
 * 
 * The idea of having only a few total abilities came from last month's theme, offspring. I was thinking about evolution, then a mechanic similar to EVO, except instead of evolving into something stronger, you are limited to only a few.
 * The story is a trope, I know. But this is something I've gone through recently. I found that that was not the right way. A better way is to do the things you like/enjoy out of pure motivation. Then, when you're low on money, you will have the experience to get a job doing the thing you like (although not completely artistic).
 * I also have many aspirations. Currently they are: film director, video game designer, and musician. I can't be great at all of them, can I?
*/

/* TODO list
 * fix block hitbox
 * make jumping easier
 * move after checking collisions
 * level 2 - able to jump over the pillar
 * 
 * WANT list
 * nightmare level - move the heart to the corner of the stage, still trapped
*/
package { //do not use the default package!
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.SoundChannel;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Timer;
	import Player;
	
	public class Main extends MovieClip {
		private static var _instance:Main;
		public var levelNumber:int = 0;
		private var player:Player; //TODO: should create a static var for the instances of main, player, hud, level
		private var level:Level; //TODO: player and hud should be children of level
		private var hud:HUD;
		private const backgroundMusic:BackgroundMusic_design = new BackgroundMusic_design();
		private var bgmSoundChannel:SoundChannel;
		private var totalRightGoals:int = 0;
		private var totalWrongGoals:int = 0;
		private var firstSkill:String;
		private var secondSkill:String;
		private const rightDialogue:Array = [ //TODO: should have used a binary tree
			"I knew it. You were always bright. I knew you'd notice that the \"real world\" is no different than your childhood.",
			"It's okay. Don't let the businessmen get to you. At least you're still doing the thing you love most.",
			"So much time has passed and you still do not have a great achievement to show it. Perhaps running was not the right choice"
		];
		private var wrongDialogueJack:Array = [
			"I knew it. You were always bright. I knew you'd notice that the \"real world\" is no different than your childhood.",
			"Wow, you're really good at secondSkill too? Huh, I always envisioned you as a firstSkill as a child. Maybe secondSkill is your thing anyway.",
			"Bored of running and jumping, and now trying to shoot? I warned you from the beginning, you have to stick to one thing if you ever want to be great."
		];
		private const wrongDialogue:Array = [
			"Don't worry, there will always be obstacles. Just stay focused!",
			"What have you be doing all of this time? C'mon, get out and do something!",
			"It seems you're stuck in the same routine. I don't think you'll ever change, and I don't feel I'm able to influence your choices anymore..."
		];
		private const twentyFiveSeconds:Timer = new Timer(25000, 1);
		
		public function Main():void {
			_instance = this;
			/*
			//title screen
			the jack of all trades. by rahil patel. press space to continue.

			//story intro
			A scene with a mother talking to the player. You are special. You're not like the rest of 'em. You have dreams. You have the power to do whatever you want. But you can't choose everyhting. You can be a great musician, film director or video game developer, but not all three. You can't have everyhting you want in life; You must learn to compromise...And remember to relax sometime. Okay?

			//level 1 - childhood
			A dog chases the player. Run Rahil run! Never look back. Keep going.
			
			//level 2 - school
			Jump Rahil jump! You must reach the top.
			
			//level 3 - college
			Shoot them Rahil. Don't let anything ever stop you.
			
			See, it's not impossible. As long as you have ambition and motivation, you will get there. Now, go on to the real world...And remember, try as hard as you can!
			
			//level 4 - post college			
			
			if success: I knew it. You were always bright. I knew you'd notice that the "real world" is no different than your childhood.
			if fail: Don't worry, there will always be obstacles. You're still young. Just stay focused!
			//level 5 - post 30s
			and remember, don't let the world shape you into something you aren't!
			
			if success: Wow, you're really good at jumping/filmmaking too? Huh, I thought you always loved running/making music. Maybe jumping is your thing anyway.
			if fail: What have you be doing all of this time? C'mon, get out and do something!
			//level 6 - post 40s
			
			if success: Bored of jumping/filmmaking now and trying something else? You have to stick to one thing if you ever want to be great at it.
			if fail: It seems you are stuck in the same routine. I don't think you'll ever change. [but I'll never lose hope in you]
			//last level

			if success: *raspy voice* Come close Rahil. I'm sorry that I've been harsh on you. You've done so many great things. I'm proud of you. 
			if fail: *raspy voice* Come close Rahil. I'm sorry that I've been harsh on you. All I ever wanted was you to be somebody. Achieve something. Now I know that may not have been the best method of raising a kid. You know I'll always love you...as long as you're trying. (subtley show disappointment)
			*/
			this.addEventListener('pressedSpaceFromTextScreen', generateNextPart);
			twentyFiveSeconds.addEventListener(TimerEvent.TIMER_COMPLETE, generateNextPart);
			generateNextPart();
		}
		
		private function getDialogue(goalIsWrong:Boolean, realWorldLevelNumber:int):String {
			//special case for a certain dialogue
			if (realWorldLevelNumber == 1 && !goalIsWrong)
				firstSkill = "runner";
			else if (realWorldLevelNumber == 2 && !goalIsWrong) {
				if (totalRightGoals == 0)
					firstSkill = "jumper"
				else if (totalRightGoals == 1) {
					wrongDialogueJack[1] = (wrongDialogueJack[1] as String).replace("firstSkill", "runner");
					wrongDialogueJack[1] = (wrongDialogueJack[1] as String).replace("secondSkill", "jumping");
					wrongDialogueJack[1] = (wrongDialogueJack[1] as String).replace("secondSkill", "jumping");
				}
			}
			else if (realWorldLevelNumber == 3) {
				if (totalRightGoals == 1) {
					wrongDialogueJack[1] = (wrongDialogueJack[1] as String).replace("firstSkill", firstSkill);
					wrongDialogueJack[1] = (wrongDialogueJack[1] as String).replace("secondSkill", "shooting");
					wrongDialogueJack[1] = (wrongDialogueJack[1] as String).replace("secondSkill", "shooting");
				}
			}
			
			//the getDialogue function
			var dialogue:String;
			
			trace("totalWrongGoals: " + totalWrongGoals + ", totalRightGoals: " + totalRightGoals);
			
			if (!goalIsWrong) {
				dialogue = wrongDialogueJack[totalRightGoals];
			}
			
			if (goalIsWrong) {
				if (totalRightGoals == 1)
					dialogue = rightDialogue[totalWrongGoals+ 1 ];
				else //if (totalRightGoals == 0 || totalRightGoals == 2)
					dialogue = wrongDialogue[totalWrongGoals];
			}
			
			//TODO: wrong -> right -> wrong, returns right[3]
			
			goalIsWrong ? totalWrongGoals++ : totalRightGoals++;
			return dialogue;
		}
		
		public static function get instance():Main {
			return _instance;
		}
		
		public function generateNextPart(event:Event = null, goalIsWrong:Boolean = false):void {
			var titleScreen:TextScreen;
			var dialogue:String;
			
			switch (levelNumber) {
				//intro
				case 0:
					titleScreen = new TextScreen(this.stage, "the jack of all trades\n" + "by rahil patel\n\n" + "press space to continue");
					this.addChild(titleScreen);
					break;
				case 1:
					titleScreen = new TextScreen(this.stage, "instructions\n\nUse the arrow keys or wasd to move and jump.\nPress space to fire and to continue");
					this.addChild(titleScreen);
					break;
				case 2:
					titleScreen = new TextScreen(this.stage, "You are special. You're not like the rest of 'em. You have dreams. You have the power to do whatever you want. But you can't choose everything. You can be a great runner, jumper, or shooter, but not all three. You can't have everything you want in life; You must learn to compromise...And remember to relax sometime. Okay?", true);					
					this.addChild(titleScreen);
					break;
				case 3:
					titleScreen = new TextScreen(this.stage, "childhood\n\nRun! Never look back. Keep going.", false);
					this.addChild(titleScreen);
					break;
					
				//training levels
				case 4:
					startLevel(0);
					break;
				case 5:
					endLevel();
					titleScreen = new TextScreen(this.stage, "school\n\nJump! You must reach the top.");
					this.addChild(titleScreen);
					break;
				case 6:
					startLevel(1);
					break;
				case 7:
					endLevel();
					titleScreen = new TextScreen(this.stage, "college\n\nShoot! Don't let anything ever stop you.");
					this.addChild(titleScreen);
					break;
				case 8:
					startLevel(2);
					break;
				case 9:
					endLevel();
					titleScreen = new TextScreen(this.stage, "See, it's not impossible. As long as you have ambition and motivation, you will get there. Now, go on to the real world.", true);
					this.addChild(titleScreen);
					break;
					
				//real levels
				case 10:
					titleScreen = new TextScreen(this.stage, "real world\n\npart 1"); //TODO: remove?
					this.addChild(titleScreen);
					break;
				case 11:
					startLevel(3);
					break;
				case 12:
					endLevel();
					titleScreen = new TextScreen(this.stage, getDialogue(goalIsWrong, 1), true);
					this.addChild(titleScreen);
					break;
				
				case 13:
					titleScreen = new TextScreen(this.stage, "real world\n\npart 2");
					this.addChild(titleScreen);
					break;
				case 14:
					startLevel(4);
					break;
				case 15:
					endLevel();
					titleScreen = new TextScreen(this.stage, getDialogue(goalIsWrong, 2), true);
					this.addChild(titleScreen);
					break;
					
				case 16:
					titleScreen = new TextScreen(this.stage, "real world\n\npart 3");
					this.addChild(titleScreen);
					break;
				case 17:
					startLevel(5);
					break;
				case 18:
					endLevel();
					titleScreen = new TextScreen(this.stage, getDialogue(goalIsWrong, 3), true);
					this.addChild(titleScreen);
					break;
					
				//infinite level
				case 19:
					titleScreen = new TextScreen(this.stage, "real world\n\npart 4");
					this.addChild(titleScreen);
					break;
				case 20:
					startLevel(6);
					if (!twentyFiveSeconds.running)
						twentyFiveSeconds.start();
					break;
				case 21:
					if(this.stage.getChildByName("level"))
						endLevel();
					if (totalRightGoals >= 1)
						titleScreen = new TextScreen(this.stage, "*raspy voice* Come close. I'm sorry that I've been harsh on you. You've done so many great things. You've never gave up. I'm proud of you.", true);
					else
						titleScreen = new TextScreen(this.stage, "*raspy voice* Come close. I'm sorry that I've been harsh on you. All I ever wanted was you to be somebody. Achieve something. You know I'll always love you...I just wished you tried harder.", true);
					this.addChild(titleScreen);
					break;
					
				//nightmare level
				case 22:
					startLevel(7);
					//if (!twentyFiveSeconds.running)
					//	twentyFiveSeconds.start();
					var theEndText:TextField = new TextField();
					theEndText.text = ("the end")
					theEndText.x = (this.stage.stageWidth / 2) - (theEndText.width / 2);
					theEndText.y = ((this.stage.stageHeight / 2) - (theEndText.height / 2)) + 50;
					theEndText.textColor = 0xCCFF00;
					theEndText.backgroundColor = 0x000000;
					theEndText.autoSize = TextFieldAutoSize.CENTER;
					theEndText.name = "theEndText";
					this.stage.addChild(theEndText);
					break;
					
				default:
					trace('default case');
					break;
			}
			
			levelNumber++;
		}
		
		private function startLevel(mapNumber:int):void {
			player = new Player(this.stage); //TODO: should be a child of level?
			this.stage.addChild(player); //TODO: should use this.addChild instead of Stage
			level = new Level(this.stage, mapNumber);
			this.stage.addChild(level);
						trace(player.x + " " + player.y)
			hud = new HUD(this.stage); //TODO: should also be a child of level
			this.stage.addChild(hud);
			player.startLoop();
			bgmSoundChannel = backgroundMusic.play();
		}
		
		private function endLevel():void {
			bgmSoundChannel.stop();
			if (this.stage.getChildByName("player")) //TODO: last minute fix, in case the player dies and the level changes
				player.endLoop();
			
			if (this.stage.getChildByName("level")) {
				level.deconstruct();
				this.stage.removeChild(level); //TODO: level = null, player = null, hud = null?
			}
			if (this.stage.getChildByName("player"))
				this.stage.removeChild(player);
			if (this.stage.getChildByName("hud"))
				this.stage.removeChild(hud);
		}
		
		public function restartLevel(event:Event = null):void {
			if (levelNumber == 23) { //TODO: last minute, special case for the nightmare level
				player.endLoop();
				this.stage.removeChild(player);
				this.stage.removeChild(hud);
				player = new Player(this.stage);
				player.x = 250;
				player.y = 350;
				this.stage.addChild(player);
				hud = new HUD(this.stage); //TODO: should also be a child of level
				this.stage.addChild(hud);
				player.startLoop();
				return;
			}
			
			endLevel();
			levelNumber--;
			generateNextPart();
		}
	}
}

//TODO: remove listeners when destroying the level, WeakReference vs removeEventListener

/* should have used the following flow...next time!

while( user doesn't exit )
  
check for user input

run AI

resolve collisions

draw graphics

play sounds

end while


for actionscript:
main {
	enterFrameHandler {
		check for user input
		run AI - move sprites
		resolve collisions
		draw graphics
		play sounds
	}
}

*/