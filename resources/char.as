onClipEvent (load) {
	jumping = false;
	// jumping is true
	speed = 0;
	// speed is 0
	//////////////////////
	////Ammendment 1//
	//////////////////
	healthX = _root.health._x;
	//sets healthX to the starting X postition of the "health" MC
	scoreX = _root.score._x;
	//sets scoreX to the starting X postition of the "score" MC
	Xpos = this._x;
	//sets Xpos to the starting X postition of this MC
	Ypos = this._y;
	//sets Ypos to the starting Y postition of this MC
	////////////////
	///////
	maxmove = 15;
	// maxmove is fifteen(max run seed)
	_root.maxshoottime = 100;
	// _root.maxshoottime is set to 100
	// this is how far you want the bullets to travel before deleting
}
onClipEvent (enterFrame) {
	//////////////////////
	////Ammendment 2//
	//////////////////
	_x = Xpos-_root._x;
	//sets the X pos to the starting X postition of this MC
	_root.score._x = scoreX-_root._x;
	//sets the scire MCs X pos to its starting point on the screen
	_root.health._x = healthX-_root._x;
	//sets the health MCs X pos to its starting point on the screen
	if (!_root.ground.hitTest(this._x, this._y, true) && !jumping) {
		// if NOT hitting X and Y postion with the ground and NOT jumping
		this._y += 6;
		// Y positon moves up 6
	}
	//////////////// 
	///////
	if (!_root.shooting) {
		// if _root.shooting is false
		_root.timer = 0;
		// _root.timer is set to 0
		_root.mvsp = _xscale/20;
		// _root.mvsp is set to the chars xscale divided by 20
		// the answer to this is the speed of the bullets
	}
	if (_root.dead) {
		// if dead is true
		this.gotoAndStop("dead");
		// goto and stop on the "dead" frame
	} else {
		// otherwise (if they are not dead)
		speed *= .85;
		// speed is multiplied by .85
		// the lower the faster is slows
		if (dir == "right" && !_root.leftblock.hitTest(this._x+20, this._y, true)) {
			_root.health._x += speed;
			// moves the health, the opposite way to the _root
			_root.score._x += speed;
			// moves the score, the opposite way to the _root
			this._x += speed;
			// moves the char, the opposite way to the _root
			_root._x -= speed;
			// moves the _root
		}
		//////////////////////   
		////Ammendment 3//
		//////////////////
		if (speed>0) {
			//if speed is smaller than 0
			dir = "right";
			// the variable dir is set to right
		} else if (speed<0) {
			//if speed is greater than 0
			dir = "left";
			// the var dir is set to left
		}
		if (dir == "left" && !_root.rightblock.hitTest(this._x-20, this._y, true)) {
			_root.health._x += speed;
			// moves the health, the opposite way to the _root
			_root.score._x += speed;
			// moves the score, the opposite way to the _root
			this._x += speed;
			// moves the char, the opposite way to the _root
			_root._x -= speed;
			// moves the _root
		}
		if (Key.isDown(Key.LEFT)) {
			// if left is pressed
			if (speed>-maxmove) {
				// if the speed is greater than neg. maxmove
				speed--;
				// speed goes lower
			}
			this.gotoAndStop("run");
			// goto and stop the run frame
			this._xscale = -100;
			// scale is set to neg. 100
			// this is what rotates ur char
			/////////////////// 
			///////////////
		} else if (Key.isDown(Key.RIGHT)) {
			// otherwise if right is pressed
			if (speed<maxmove) {
				// if the speed is smaller than maxmove
				speed++;
				// speed goes up
			}
			this._xscale = 100;
			// scale is set to  100
			// this is what rotates ur char
			this.gotoAndStop("run");
			// goto and stop the run frame
		} else if (Key.isDown(Key.CONTROL)) {
			// otherwise if control is pressed
			this.gotoAndStop("attack");
			// goto and stop the attack frame
			attacking = true;
			// attacking is true
			speed = 0;
			// speed is set to 0
		} else if (Key.isDown(Key.SPACE)) {
			// otherwise if space is pressed
			if (_root.gotgun == true && !_root.shooting) {
				// if _root.gotgun is true(they have the gun) and _root.shooting is false
				_root.attachMovie("bullet", "bulleter", 1, {_x:_root.char._x, _y:_root.char._y-25});
				// attach the movie with the Linkage name "bullet" to the _root at the character X position and the Y position minus 25
				_root.shooting = true;
				// _root.shooting is set true
				with (_root.bulleter) {
					// all code below this code and it's closer refer to _root.bulleter
					onEnterFrame = function () {
						// setting the onEnterFrame events (onClipEvent)
						if (_root.timer>_root.maxshoottime) {
							// if _root.timer is smaller than _root.maxshoottime
							_root.shooting = false;
							// shooting is false
							unloadMovie(this);
							// this movie clip is unloaded
						}
						_root.timer++;
						// _root.timer goes up 1
						_x += _root.mvsp;
						// the X goes up _root.mvsp (which is set constantly and stays the same when shooting.)                    };
					};
				}
				attacking = true;
				// attacking is true
				speed = 0;
				// speed is set to 0
				this.gotoAndStop("shoot");
				// goto and stop on the shoot frame
			}
		} else if (speed<1 && speed>-1 && !attacking) {
			// if speed is smaller than one and greater than neg. 1
			speed = 0;
			// speed is set to 0
			this.gotoAndStop("idle");
			// gotoAndStop the idle frame
		}
		if (Key.isDown(Key.UP) && !jumping) {
			// if up is pressed and NOT jumping
			jumping = true;
			// jumping is set true
		}
		if (jumping) {
			// if jumping is true
			this.gotoAndStop("jump");
			this._y -= jump;
			// Y position is set down jump
			jump -= .5;
			// jump is set down .5
			if (jump<0) {
				// if jump is smaller than 0
				falling = true;
				// falling is true
			}
			if (jump<-15) {
				// if jump is smaller than neg. 5
				jump = -15;
				// jump is set to neg 5
				// capping fall speeds prevents falling through grounds
			}
		}
		if (_root.ground.hitTest(this._x, this._y, true) && falling) {
			// if hitting X an Y postions with the ground and falling
			jump = 12;
			// jump is set to 9
			jumping = false;
			// jumping is false
			falling = false;
			// falling is false
		}
	}
}
onClipEvent (keyUp) {
	// on Key Up
	if (Key.getCode() == Key.CONTROL) {
		// if the release is control
		attacking = false;
		// attacking is false
	}
}
