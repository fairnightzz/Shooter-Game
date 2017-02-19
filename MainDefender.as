package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.text.*;//textfield import
	import flash.ui.Keyboard;
	import flash.utils.*
	public class MainDefender extends MovieClip
	{
		//1. Player
		var p:Player1;
		
		//2. Bullet
		var bullet:Fire;
		var bArray:Array;//with the array
		
		//3. Facebook Enemy Number 1
		var facebook:Minion;
		
		//4. Minion 2, which is instagram! I might make it shoot bullets likes and posts
		var instagram:Minion2;
		
		//5. Twitter, which is the bird that moves diagonally
		var twitter:Bird;
		
		//6. The ghost boss Snapchat
		var snapchat:Boss;
		
		//7. Velocity of player (might change when characters go to fast)
		var vy:int;
		
		//8. disable auto fire
		var testb:Boolean=false;
		var testa:Boolean=true;
		
		

		public function MainDefender()//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			//1. Player start
			p=new Player1();
			p.x=150;
			p.y=360;
			stage.addChild(p);
			
			//2. Bullet array
			bArray=new Array();
			
			//3. Minion Facebook
			for (var x:int=0;x<5;x++)
			{
				facebook=new Minion();
			facebook.x=1280;
			facebook.y=Math.random()*720;
			stage.addChild(facebook);
			}
			
			
	
	
			stage.addEventListener(Event.ENTER_FRAME,gameLoop); //loop
			stage.addEventListener(KeyboardEvent.KEY_DOWN,movement); //meh let's add shooting as well
			stage.addEventListener(KeyboardEvent.KEY_UP,nomovement);//to detect whether key is released. Good for when other keys are pressed
			
			
		}//end CONSTRUCTOR
		
		public function movement(e:KeyboardEvent)//player move
		{
			if (e.keyCode==Keyboard.UP)
			{
				vy=-10;
				//p.y+=-10;
			}
			if (e.keyCode==Keyboard.DOWN)
			{
				vy=10;
				//p.y+=10;
			}
			if (e.keyCode==Keyboard.SPACE)
			{
				//since the bullets are going way too fast, we add a timer
				if (testa==true)
				{
					testb=true;//making the bullet true
					testa=true;
					trace("hi")
				}
				
			}
			
		}
		
		public function nomovement(e:KeyboardEvent)
		{
			if (e.keyCode==Keyboard.UP)
			{
				vy=0;
				//p.y+=-10;
			}
			if (e.keyCode==Keyboard.DOWN)
			{
				vy=0;
				//p.y+=10;
			}
			if (e.keyCode==Keyboard.SPACE)
			{
				testb=false;//false if released
				testa=true;
				trace("wut")
			}
		}
		
		public function gameLoop(e:Event)
		{
			//player move
			p.y+=vy;
			//player boundary
			if (p.y<0)
			{
				p.y=0;
			}
			else if (p.y>720)
			{
				p.y=720;
			}
			//bullet adding, and pushing towards array
			if (testb==true)
				{
					//double to make sure there's no fire
					if (testa==true)
					{
						bullet=new Fire();
						bullet.x=150;
						bullet.y=p.y;
						stage.addChild(bullet);
						bArray.push(bullet);
						trace(bArray);
						testb==false;
						testa=false;
					}
					
				}
			for (var j:int=0;j<bArray.length;j++)
			{
				//for each bullet on the screen move it
				//10 pixels right if it is still visible
				if (bArray[j].x<1280)
				{
					bArray[j].x+=10;
				}//end if
				else
				{	//remove the bullets that are NOT on the stage
					//order is IMPORTANT
					//1.remove from the stage
					stage.removeChild(bArray[j]);
					//2.remove from the array
					bArray.splice(j,1);
				}
				//For if the bullet hits facebook, it will respawn in a different area
				if (facebook!=null && bArray[j]!=null && bArray[j].hitTestObject(facebook))
				{
					facebook.y=Math.random()*720;
					facebook.x=1280;
					stage.removeChild(bArray[j]);
					bArray.splice(j,1);
				}
			}//end for
			
			//moving
			facebook.x+=-5;
			
		}
	}//end class
}//end package