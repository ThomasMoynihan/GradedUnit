///////////////////////////////////////////////////////////////////////////
// By: Alan Yeats
// HNC COMPUTER GAME DEVELOPEMENT 
// GRADED UNIT
////////////////////////////////////////////////////////////////////////////
//	Use: 		The main where all functions are being called and such.
////////////////////////////////////////////////////////////////////////////


stop();		// Stop the timeline as everything will be done from movie clips and thus be on the one frame

// Imports
import flash.display.Sprite;
import flash.events.*;
import flash.display.MovieClip;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.ui.Keyboard;
import flash.ui.Mouse;
import flashx.textLayout.accessibility.TextAccImpl;
import flash.sampler.StackFrame;
import flash.utils.Timer;
import flashx.textLayout.edit.IInteractionEventHandler;



var bmionion:basic_M = new basic_M();		// Declaring graphics for basic minion

addEventListener(Event.ENTER_FRAME, everFrame);		// Add listners for every entry of every frame

stage.addEventListener(MouseEvent.CLICK, makeEnemiesClick); // Add Listner To check when player clicks mouse


										// chars doing to be used to create movement tiles

var S:String = 'START';					// Start movement
var R:String = 'RIGHT';					// Right Movement
var D:String = 'DOWN';					// Down Movement
var L:String = 'LEFT';					// Left Movement

var F:String = 'FINISH';				// Finish movement
var U:String = 'UP';					// UP movement


var TB:String = 'BTURRET';				// Basic Turret
var TS:String = 'STURRET';				// Slow Turret
var TA:String = 'AOETURRET';			// AOE Turret
										// Can add more turrets later



var levelWin:Boolean = false;			// For the win level state to settign to false to start
var gameOver:Boolean = false;			// Set the game over state to false 



var startDir:String;					// Start Direction
var finDir:String;						// Finish Direction
var startCoord:int;						// The Start Coords


var lvlOneArray:Array = new Array();	// Creating the Array to hold the first level Map
var lvlTwoArray:Array = new Array();	// Creating the Array to hold the Second level Map	

										
var money:int;							// Inigicating the money the player will have  


var castleH:int;						// Starting to Heath of the castle

									
var basMinCount:int;					// Counter for cooldown for basic minion
var intMinCount:int;					// Counter for cooldown for intermediate minion
var medMinCount:int;					// Counter for cooldown for Medium minion
var larMinCount:int;					// Counter for cooldown for large minion
var tankMinCount:int;					// Counter for cooldown for tank minion

var basMinCool:int		= 15; 			// The cooldown between when the player can call in basic minions
var intMinCool:int 		= 30; 			// The cooldown between when the player can call in Intermedite minions
var medMinCool:int		= 60;			// The cooldown between when the player can call in medium minions
var larMinCool:int		= 70;			// The cooldown between when the player can call in large minions
var tankMinCool:int 	= 80;			// The cooldown between when the player can call in tank minions

var basCost:int 	= 20;				// Cost of each basic minion
var intCost:int 	= 50;				// Cost of each intermediate minion
var medCost:int 	= 80;				// Cost of each medim minion
var larCost:int 	= 110;				// Cost of each Large minion
var tankCost:int	= 250;				// Cost of each tank minion


var totalMinions:int;					// Total minions stat

var turretCount:int;					// Creating a cout for number of turrets 
var sTurretCount:int; 					// Creating a cout for number of slow turrets 

var minionOnStage:int;					// Find the total 




var minBNameTxt:TextField = new TextField;			// Creating Text Field For name of Basic minions
var minINameTxt:TextField = new TextField;			// Creating Text Field For name of Intermdiate minions
var minLNameTxt:TextField = new TextField;			// Creating Text Field For name of Large minions
var minTNameTxt:TextField = new TextField;			// Creating Text Field For name of Tank minions
	


var headerHolder:Sprite = new Sprite				// Creates the header holder 


lvlOneArray = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,R,1,1,D,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,
S,1,1,D,0,0,0,0,1,0,0,R,1,1,1,1,1,1,1,1,1,F,
0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,1,0,0,R,1,U,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,R,1,1,U,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,R,1,1,1,1,U,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
//got to be changed when get finnonghy map
];
lvlTwoArray = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
S,R,R,D,0,0,0,0,0,0,0,0,R,R,R,R,R,R,R,R,R,F,
0,0,0,D,0,0,0,0,0,0,0,0,U,0,0,0,0,0,0,0,0,0,
0,0,0,D,0,0,0,0,0,0,0,0,U,0,0,0,0,0,0,0,0,0,
0,0,0,D,0,0,0,0,0,0,0,0,U,0,0,0,0,0,0,0,0,0,
0,0,0,R,R,R,R,R,R,R,R,R,U,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
//got to be changed when get finnonghy map
];

function startLvl():void 						// Start Game Function 										
{												// Will run at the start of each level
	
	stage.addEventListener(KeyboardEvent.KEY_DOWN,makeEnemiesKey);		// add listners for keyboard commands passing to make enemies function


	basMinCount  = 0;							// Inisating timers to 0 when each level starts
	intMinCount  = 0;
	larMinCount	 = 0;
	tankMinCount = 0;
	
	turretCount  = 0;							// Setting number of towers to 0
	sTurretCount = 0;							// Setting number of slow towers to 0				
	
	castleH = 1;								// Reseting the health of the casle as the level starts
														
	minionOnStage = 0;
	money = 50;									// Resesting the starting money for the player per round
												
	currentLvl ++;								// Increasing the level each time this level is completed
	
	
	placeTurrets();								// call placeTurret function

	
	
}


var roadHolder:Sprite = new Sprite();			// Create a new Sprite to hold the road 
addChild(roadHolder);							// sending the road to the stage


function makeRoad(lvl:int):void						// Make Road Funcion 
{
	var lvlArray;
	var row:int = 0;								// Inilising row 
	var block;										// Inilising Block var

	switch(lvl)
	{
	case 1:

	for (var i:int=0; i<lvlTwoArray.length; i++)		// Loop though Lvel Array 
	{ 


///////////////////////////////////////////////////////////////////////////		
		
		if (lvlTwoArray[i] == 1)					// If it a path block
		{
			block = new Shape();
			block.graphics.beginFill(0x111111);
			block.graphics.drawRect(0,0,25,25);
			block.graphics.endFill();				// Will remove once get map and graphics
			block.x = (i - row * 22) * 25;
			block.y = row * 25;
			roadHolder.addChild(block);
		}
///////////////////////////////////////////////////////////////////////////		
		else if (lvlTwoArray[i] is String)				// If its a movement block
		{
			block = new DirectBlock(lvlTwoArray[i],(i - row * 22) * 25,row * 25);		//Create a new Direction Block
			addChild(block);						// Send Block To the stage

		}
		for (var col:int = 1; col<=16; col++)				// Loop for number of cols
		{
			if (i == col*22-1)								// If reach end of col
			{
				row++;										// move to the next col
			} // end if
			
		}// end for

	} // end for
	
	break;
	
	case 2: 
	for (var j:int=0; j<lvlOneArray.length; j++)		// Loop though Lvel Array 
	{ 


///////////////////////////////////////////////////////////////////////////		
		
		if (lvlOneArray[j] == 1)					// If it a path block
		{
			block = new Shape();
			block.graphics.beginFill(0x111111);
			block.graphics.drawRect(0,0,25,25);
			block.graphics.endFill();				// Will remove once get map and graphics
			block.x = (j - row * 22) * 25;
			block.y = row * 25;
			roadHolder.addChild(block);
		}
///////////////////////////////////////////////////////////////////////////		
		else if (lvlOneArray[j] is String)				// If its a movement block
		{
			block = new DirectBlock(lvlOneArray[j],(j - row * 22) * 25,row * 25);		//Create a new Direction Block
			addChild(block);						// Send Block To the stage

		}
		for (var cols:int = 1; cols<=16; cols++)				// Loop for number of cols
		{
			if (i == cols*22-1)								// If reach end of col
			{
				row++;										// move to the next col
			} // end if
			
		}// end for

	} // end for
	
}// end of switch 

}// end of function



function placeTurrets():void					// Place Turret Function
{												// just hardcoded will make array letter
	if (currentLvl == 1)
	{	
		makeTurret(300,140,1);					// Makes Slower Tower
		makeTurret(100,200,1);					// Makes Basic tower
		makeTurret(220,140,1);					// Makes Slow Tower 
	}
	if (currentLvl == 2)
	{
	
		makeTurret(100,250,1);
		makeTurret(400,200,1);
		makeTurret(120,140,2);
	}

//	makeTurretB(125,75);
//	makeTurretB(250,75);
//	makeTurretB(50,150);
//	makeTurretS(75,150);
//	makeTurretB(100,150);
}

function restartStage(){
//lowerThird();
	trace("reset stage");
	montxt.x = 750;
	montxt.y = 750;
	heathtxt.x = 750;
	heathtxt.y = 750;
	timertxt.x = 750;
	timertxt.y = 750;
	graphics.clear();
	
	
	minBNameTxt.x = 5000;
	minLNameTxt.x = 5000;
	minTNameTxt.x = 5000;
	minINameTxt.x = 5000;
	
	//roadHolder.parent.removeChildren(0,25);
	//roadHolder.parent.removeChildren(0,10);
}


function makeTurret(xValue:int,yValue:int,tower:int):void		// Make Turret Function
																// Pass x and y values and
																// Turret type
																// 1 for Basic tower
																// 2 for Slow Tower
																
{

		if(tower == 1)								// If basic Tower
		{
			turretCount++;							// Add to the turret count
			var turret:Turret = new Turret();		// Create a new Basic tower
			turret.x = xValue + 12.5;				// Set X value based on Xvalue Passed 
			turret.y = yValue + 12.5;				// Set Y value based on Yvalue Passed 
			addChild(turret);						// Sending Turret to Stage
			turret.name = "Turret" + turretCount;
		}else if(tower == 2)						// IF slow Tower
		{
			sTurretCount++;							// Add to the slow tower count
			var sT:SlowTurret = new SlowTurret()	// Creating new slow tower
			sT.x = xValue + 12.5;					// Set X value based on Xvalue Passed 
			sT.y = yValue + 12.5;					// Set Y value based on Yvalue Passed 
			addChild(sT);							// Sending Turret to Stage
			sT.name = "SlowTurret" + sTurretCount;
		}
					
	
}

function makeEnemiesKey(event:KeyboardEvent):void		 // Make Enemy Function
{
	
	
	if (event.keyCode == 81 && basMinCount == basMinCool && money >= basCost) {// Testing if player has hit Q key and cooldown is at 0 and have enough money to buy the minion
	
		minionOnStage ++;										// Adds to minions on stage
		//trace("q key has been pressed");						// output a debug message 
		var basicM:Enemy = new Enemy();							// Create a intance of basic enemy
		enemyHolder.addChild(basicM);							// Send intance to stage
		basMinCount -= basMinCool;								// Reset Cooldown
		money -=basCost;										// Take cost of minion away from money total 
		totalMinions ++;										// Adding to total minions count
		
	}
	
	if (event.keyCode == 87 && intMinCount == intMinCool && money >= intCost) {// Testing if player has hit W key and the cooldown 
		minionOnStage ++;										// Adds to minions on stage		
		//trace("w key has been pressed");						// output a debug message
		var interM:InterEnemy = new InterEnemy();				// Create a intance of intermediate enemy
		enemyHolder.addChild(interM);							// Send intance to the stage
		intMinCount -= intMinCool;								// Reset Cooldown
		money -=intCost;										// Take cost of minions away from money total
		totalMinions ++;										// Adding to total minions count
	}	
	
	if (event.keyCode == 69 && medMinCount == medMinCool && money >= medCost) {// Testing if player has hit E key and the cooldown 
		minionOnStage ++;										// Adds to minions on stage	
	//trace("e key has been pressed");						// output a debug message
		var medM:MedEnemy = new MedEnemy();						// Create a intance of intermediate enemy
		enemyHolder.addChild(medM);								// Send intance to the stage
		medMinCount -= medMinCool 								// Reset Cooldown
		money -=medCost;										// Take cost of minions away from money total
		totalMinions ++;										// Adding to total minions count
	}		
	
	if (event.keyCode == 82 && larMinCount == larMinCool && money >= larCost) {// Testing if player has hit E key and the cooldown 
		//trace("r key has been pressed");						// output a debug message
		var largeM:LargeEnemy = new LargeEnemy();				// Create a intance of intermediate enemy
		enemyHolder.addChild(largeM);							// Send intance to the stage
		larMinCount -= larMinCool 								// Reset Cooldown
		money -=larCost;										// Take cost of minions away from money total
		totalMinions ++;										// Adding to total minions count
	}	
	if (event.keyCode == 84 && tankMinCount == tankMinCool && money >= tankCost) {// Testing if player has hit E key and the cooldown 
		minionOnStage ++;										// Adds to minions on stage
	//trace("t key has been pressed");						// output a debug message
		var tankM:TankEnemy = new TankEnemy();					// Create a intance of intermediate enemy
		enemyHolder.addChild(tankM);							// Send intance to the stage
		tankMinCount  -= tankMinCool							// Reset Cooldown
		money -=tankCost;										// Take cost of minions away from money total
		totalMinions ++;										// Adding to total minions count
	}		
	
}

function makeEnemiesClick(e:MouseEvent):void			// Mouse Click detection for minions creation
{
	//trace("X = " + e.stageX);							// Debug x mouse click location 
	//trace("Y = " + e.stageY);							// Debug Y mouse click location

	
	if (e.stageX >=20 && e.stageX <= 120 && e.stageY >= 417 && e.stageY <= 493
		&& basMinCount == basMinCool && money >= basCost) // Check it within the Basic minion box
	{
		minionOnStage ++;										// Adds to minions on stage
		var basicM:Enemy = new Enemy();							// Create a intance of basic enemy
		enemyHolder.addChild(basicM);							// Send intance to stage
		basMinCount -= basMinCool;								// Reset Cooldown
		money -=basCost;										// Take cost of minion away from money total 
		totalMinions ++;										// Adding to total minions count
	}
		
	if (e.stageX >=200 && e.stageX <= 297 && e.stageY >= 417  && e.stageY <= 493
		&& intMinCount == intMinCool && money >= intCost) // Check it within the Intermedate minion box
		{
		minionOnStage ++;										// Adds to minions on stage			
		var interM:InterEnemy = new InterEnemy();				// Create a intance of intermediate enemy
		enemyHolder.addChild(interM);							// Send intance to the stage
		intMinCount -= intMinCool;								// Reset Cooldown
		money -=intCost;										// Take cost of minions away from money total
		totalMinions ++;										// Adding to total minions count	
			
		}	
	if (e.stageX >=20 && e.stageX <= 120 && e.stageY >= 510  && e.stageY <= 586
		 && larMinCount == larMinCool && money >= larCost) // Check it within the Large minion box
		{
		minionOnStage ++;										// Adds to minions on stage			
		var largeM:LargeEnemy = new LargeEnemy();				// Create a intance of intermediate enemy
		enemyHolder.addChild(largeM);							// Send intance to the stage
		larMinCount -= larMinCool 									// Reset Cooldown
		money -=larCost;										// Take cost of minions away from money total
		totalMinions ++;										// Adding to total minions count				
		}
		
	if (e.stageX >=200 && e.stageX <= 297 && e.stageY >= 510  && e.stageY <= 586
		&& tankMinCount == tankMinCool && money >= tankCost) // Check it within the Tank minion box
		{
		minionOnStage ++;										// Adds to minions on stage
		var tankM:TankEnemy = new TankEnemy();					// Create a intance of intermediate enemy
		enemyHolder.addChild(tankM);							// Send intance to the stage
		tankMinCount  -= tankMinCool;							// Reset Cooldown
		money -=tankCost;										// Take cost of minions away from money total
		totalMinions ++;										// Adding to total minions count	
			
		}
}


function everFrame(e:Event):void						// Function will run every frame 
{	
	//trace(minionOnStage);
	createText();													// Call Create text to keep user updated on stats 

	if(basMinCount != basMinCool && basMinCount >= 0)				// Check timer is not at the max cooldown
	{
		basMinCount ++;												// Add to the timer
	}
	//trace("Base Cooldown: " + basMinCount);
	
	if(intMinCount != intMinCool && intMinCount >= 0)				// if its between the maxium and minimum cool down
	{
		intMinCount ++;												// Add to the timer
	}
	//trace("Intermediate Cooldown: " + intMinCool);
	
	if(medMinCount != medMinCool && medMinCount >= 0)				// if its between the maxium and minimum cool down
	{
		medMinCount ++;												// Add to the timer
	}
	//trace("Intermediate Cooldown: " + intMinCool);
	if(larMinCount != larMinCool && larMinCount >= 0)				// if its between the maxium and minimum cool down
	{
		larMinCount ++;												// Add to the timer
	}
	//trace("Large Cooldown: " +	larMinCool);
	if(tankMinCount != tankMinCool && tankMinCount >= 0)			// if its between the maxium and minimum cool down
	{
		tankMinCount ++;											// Add to the timer
	}
	//trace("Tank Cooldown: " +	tankMinCool);
	

	
	
	
	if (castleH <= 0)												// Check if Caslte still has health
	{
		levelWin = true;											// If Castle has fallen then level win
	}
	if (levelWin == true)											// If level win 
	{
													
		levelWin = false;											// Set Levelwin back to false
		startLvl();													// reset the level and call start round
		restartStage();	
		gameOver = true;
	}
	
	
	if(money < basCost && minionOnStage == 0 || money == 0 && minionOnStage == 0)						// Checks if there are many minion on screen and if they have money to buy more
	{
		gameOver = true;
		trace(gameOver);
		restartStage();
	}
	

	

}

function createText():void								// Create Text Function 
{
	
	montxt.x = 390;									// Setting X coords of money text 
	montxt.y = 440;									// Setting Y coords of money text 
	montxt.text = 'Money Left: ' + money;			// Setting Money text values
	
	heathtxt.x = 390;
	heathtxt.y = 460;
	heathtxt.text = 'Health Left: ' + castleH;
	


}
		
function scaleMask():void								// Scale Mask Function
{													// Will Make the exported Swf scale if user rescales
													// the window
	var scale:Sprite = new Sprite();
	addChild(scale);
	scale.graphics.beginFill(0x000000);
	scale.graphics.drawRect(0, 0, this.width, this.height);
	scale.graphics.endFill();
	scale.x = 0;
	scale.y = 0;
	this.mask = scale;
													// Information found on 
													//stackoverflow.com/questions/7118482/how-to-disable-resizing-of-flash-scene-in-flash-desktop-player
}

function lowerThird():void								// Lower Third Function	
														// This draws the lower area and its graphics
{

	this.graphics.beginFill(0x464646);				
	this.graphics.drawRect(0,400,550,200);				// Create Outer Box

	this.graphics.beginFill(0x999999);
	this.graphics.drawRoundRect(10,410,530,180,10,10);	// inner Large box
	
		
	minBNameTxt.x = 40;									// Lable X cords
	minBNameTxt.y = 405;								// Lable Y cords
	minBNameTxt.text = "Basic Minion";					// Lable for basic minion
	minBNameTxt.selectable = false;						// Making it so usercan't highlught tetx 
	addChild(minBNameTxt);						// sending to stage

	

	this.graphics.beginFill(0x000000);

	this.graphics.drawRoundRect(20,420,100,75,7,7); 	// Basic Minions box



//	bmionion.x = 85;									// Minion X cords for lower third 
//	bmionion.y = 430;									// Minion Y cords for lower third 
//	bmionion.scaleX = 1.5;								// Scaling X size of minion movieClip
//	bmionion.scaleY = 1.5;								// Scaling Y size of minion movieClip
//	bmionion.rotation = 90;								// Rotating the minion by 90^o
//	stage.addChild(bmionion);							// Sending to stage
	
	
	
	minionStatHeader(130,418,5,1,1,5,basCost);			// Creating Visual Display of basic minion  stats 
	
	this.graphics.beginFill(0x000000);
	this.graphics.drawRoundRect(20,510,100,75,7,7);		// Creating Large minion box

	minLNameTxt.x = 40;									// Lable X cords
	minLNameTxt.y = 492;								// Lable Y cords
	minLNameTxt.text = "Large Minion";					// Lable for basic minion
	minLNameTxt.selectable = false;						// Making it so usercan't highlught tetx 
	addChild(minLNameTxt);								// sending to stage

	graphics.beginFill(0xFF0000);						// Sending Large minion To stage
	this.graphics.drawCircle(65,545,9);					// Default image will  change once get graphic
	
	
	minionStatHeader(130,505,2,4,4,2, larCost);			// Creating Visual Display of Large minion stats 	
	
	
	this.graphics.beginFill(0x000000);					
	this.graphics.drawRoundRect(200,420,100,75,7,7);	// Creating Intermedate box
	
	minINameTxt.x = 198;								// Lable X cords
	minINameTxt.y = 405;								// Lable Y cords
	minINameTxt.text = "Intermedite Minion";			// Lable for basic minion
	minINameTxt.selectable = false;						// Making it so usercan't highlught tetx 
	stage.addChild(minINameTxt);						// sending to stage
	

	graphics.beginFill(0x00FF00);						// Sending Inntermdate minion To stage
	this.graphics.drawCircle(250,455,7);				// Default image will  change once get graphic		


	minionStatHeader(308,418,4,2,2,4, intCost);			// Creating Visual Display of Int minion stats 	


	this.graphics.beginFill(0x000000);
	this.graphics.drawRoundRect(200,510,100,75,7,7);	// Create Tank box
	
	minTNameTxt.x = 215;								// Lable X cords
	minTNameTxt.y = 492;								// Lable Y cords
	minTNameTxt.text = "Tank Minion";					// Lable for basic minion
	minTNameTxt.selectable = false;						// Making it so usercan't highlught tetx 
	stage.addChild(minTNameTxt);						// sending to stage
	
	graphics.beginFill(0xD4D4D4)						// Sending Tank minion To stage
	this.graphics.drawCircle(250,545,15);				// Default image will  change once get graphic

	minionStatHeader(308,505,1,5,5,1,tankCost);			// Creating Visual Display of Tank minion stats 	


	this.graphics.endFill();
	

}

function minionStatHeader(xPos:int, yPos:int, speed:int, health:int, damange:int, reward:int, cost:int):void				// Function creates the headers for the minions
{
	
	var speedTxt:TextField = new TextField;				// Creating Text Field For header of speed
	var costTxt:TextField = new TextField;				// Creating Text Field For the cost of minion
	var healthTxt:TextField = new TextField;			// Creating Text Field For header of health
	var damageTxt:TextField = new TextField;			// Creating Text Field For header of damange
	var rewardTxt:TextField = new TextField;			// Creating Text Field For header of reward
	
	speedTxt.x = xPos;								// Lable X cords
	speedTxt.y = yPos;								// Lable Y cords
	speedTxt.text = "Speed";						// Lable for Speed
	speedTxt.selectable = false;					// Making it so usercan't highlught tetx 
	stage.addChild(speedTxt);						// sending to stage
	
	minionStats(speed,xPos,yPos+10);				// Calling minion graphical display 
	
	healthTxt.x = xPos;								// Lable X cords
	healthTxt.y = yPos+15;							// Lable Y cords
	healthTxt.text = "Health";						// Lable for Speed
	healthTxt.selectable = false;					// Making it so usercan't highlught tetx 
	stage.addChild(healthTxt);						// sending to stage
	
	minionStats(health,xPos,yPos+25);				// Calling minion graphical display 
	
	damageTxt.x = xPos;								// Lable X cords
	damageTxt.y = yPos+30;							// Lable Y cords
	damageTxt.text = "Damage";						// Lable for Speed
	damageTxt.selectable = false;					// Making it so usercan't highlught tetx 
	stage.addChild(damageTxt);						// sending to stage
	
	minionStats(damange,xPos,yPos+40);				// Calling minion graphical display 
	
	rewardTxt.x = xPos;								// Lable X cords
	rewardTxt.y = yPos+45;							// Lable Y cords
	rewardTxt.text = "Reward";						// Lable for Speed
	rewardTxt.selectable = false;					// Making it so usercan't highlught tetx 
	stage.addChild(rewardTxt);						// sending to stage
	
	minionStats(reward,xPos,yPos+55);				// Calling minion graphical display 
	
	costTxt.x = xPos;								// Lable X cords
	costTxt.y = yPos+65;							// Lable Y cords
	costTxt.text = "Cost: $" + cost;				// Lable for Speed
	costTxt.selectable = false;						// Making it so usercan't highlught tetx 
	stage.addChild(costTxt);						// sending to stage
	
//	if (gameOver = true)
//	{
//		
//		rewardTxt.x = 5000;
//		costTxt.x	= 5000;
//		damageTxt.x = 5000;
//		healthTxt.x = 5000;
//		speedTxt.x  = 5000;
//	}
	
}

function minionStats(grade:int, xPos:int, yPos:int):void				// Function used to show the player how good each minion is 
{
 	switch(grade)											//	switch statment for grade
	{
		case 1: 
				
			graphics.beginFill(0x99FF00);					// Make 1 square
			graphics.drawRect(xPos+0.6,yPos,6,7);
			graphics.endFill();
			
			break;
		case 2:
			graphics.beginFill(0x99FF00);
			graphics.drawRect(xPos,yPos,6,7);
			
			graphics.beginFill(0x000000);
			graphics.drawRect(xPos+7,yPos,1,7);					// Make 2 square
			
			graphics.beginFill(0x99FF00);
			graphics.drawRect(xPos+9,yPos,6,7);
			graphics.endFill();

			break;
		case 3:
			graphics.beginFill(0x99FF00);
			graphics.drawRect(xPos,yPos,6,7);
			
			graphics.beginFill(0x000000);
			graphics.drawRect(xPos+7,yPos,1,7);
			
			graphics.beginFill(0x99FF00);
			graphics.drawRect(xPos+9,yPos,6,7);					// Make 3 square
						
			graphics.beginFill(0x000000);
			graphics.drawRect(xPos+16,yPos,1,7);
			
			graphics.beginFill(0x99FF00);
			graphics.drawRect(xPos+18,yPos,6,7);
			graphics.endFill();
			
			break;
		case 4:
			graphics.beginFill(0x99FF00);
			graphics.drawRect(xPos,yPos,6,7);
			
			graphics.beginFill(0x000000);
			graphics.drawRect(xPos+7,yPos,1,7);
			
			graphics.beginFill(0x99FF00);
			graphics.drawRect(xPos+9,yPos,6,7);
						
			graphics.beginFill(0x000000);
			graphics.drawRect(xPos+16,yPos,1,7);
			
			graphics.beginFill(0x99FF00);
			graphics.drawRect(xPos+18,yPos,6,7);					// Make 4 square
			
			graphics.beginFill(0x000000);
			graphics.drawRect(xPos+25,yPos,1,7);
			
			graphics.beginFill(0x99FF00);
			graphics.drawRect(xPos+27,yPos,6,7);
			graphics.endFill();
			break;
		case 5:
			graphics.beginFill(0x99FF00);
			graphics.drawRect(xPos,yPos,6,7);
			
			graphics.beginFill(0x000000);
			graphics.drawRect(xPos+7,yPos,1,7);
			
			graphics.beginFill(0x99FF00);
			graphics.drawRect(xPos+9,yPos,6,7);
						
			graphics.beginFill(0x000000);
			graphics.drawRect(xPos+16,yPos,1,7);
			
			graphics.beginFill(0x99FF00);
			graphics.drawRect(xPos+18,yPos,6,7);
			
			graphics.beginFill(0x000000);
			graphics.drawRect(xPos+25,yPos,1,7);					// Make 5 square
			
			graphics.beginFill(0x99FF00);
			graphics.drawRect(xPos+27,yPos,6,7);
			
			graphics.beginFill(0x000000);
			graphics.drawRect(xPos+34,yPos,1,7);
			
			graphics.beginFill(0x99FF00);
			graphics.drawRect(xPos+36,yPos,6,7);
			graphics.endFill();
			break;
			
			default:
			break;
	
	}
}


											// Functions that will only need to be called once 
											
lowerThird();								// Call lower third function
makeRoad(currentLvl);									// call make road function
var enemyHolder:Sprite = new Sprite();		
addChild(enemyHolder);						
startLvl();									// call lvl game function	
//scaleMask();								// call scale mask function


