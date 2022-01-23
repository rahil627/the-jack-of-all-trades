onClipEvent (load) {
	enemyspeed = 2;
	// this sets the speed your enemy will move at
	enemystepsright = 0;
	// how far it has moved right
	enemystepsleft = 0;
	// how far it has moved left
	enemydir = "left";
	// its direction is set left
}
onClipEvent (enterFrame) {
	if (this.hitTest(_root.char.attackpoint)) {
		// if it hits the attackpoint in the character MC
		enemyspeed = 0;
		// its speed is set to 0
		enemystepsright = 0;
		// how far it has moved right is set to 0
		enemystepsleft = 0;
		// how far it has moved left set to 0
		dead = true;
		// dead is true
		this.gotoAndStop("dead");
		// goto and stop on the dead frame
	}
	if (this.hitTest(_root.bulleter)) {
		// if this hits the bullet (_root.bulleter)
		enemyspeed = 0;
		// its speed is set to 0
		enemystepsright = 0;
		// how far it has moved right is set to 0
		enemystepsleft = 0;
		// how far it has moved left set to 0
		dead = true;
		// dead is true
		this.gotoAndStop("dead");
		// goto and stop on the dead frame
	}
	if (this.hitTest(_root.char) && !dead) {
		// if this hits the character and is not dead
		_root.char.jumping = false;
		// characters jumping state is set false
		_root.dead = true;
		// _root.dead is set true
	}
	if (!dead) {
		// if NOT dead
		if (enemydir == "right") {
			// if the direction (enemydir) is right
			enemystepsright += 1;
			// its amount of steps (enemystepsright) right goes up 1
			this._xscale = -100;
			// _xscale (flips character) is set to neg. 100
			this._x += enemyspeed;
			// its X goes up the value of enemyspeed
		} else if (enemydir == "left") {
			// otherwise if the direction (enemydir) is left
			enemystepsleft += 1;
			// its amount of steps (enemystepsright) left goes up 1
			this._xscale = 100;
			// _xscale (flips character) is set to 100
			this._x -= enemyspeed;
			// its X goes down the value of enemyspeed
		}
		if (enemystepsright == 100) {
			// if enemystepsright is equal to 100
			enemystepsright = 0;
			// enemystepsright is set to 0
			enemydir = "left";
			// direction is set to left
		} else if (enemystepsleft == 100) {
			// otherwise if enemystepsleft is equal to 100
			enemystepsleft = 0;
			// enemystepsleft is set to 0
			enemydir = "right";
			// direction is set to right
		}
	}
}
