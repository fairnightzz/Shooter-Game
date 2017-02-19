package
{
	import flash.display.MovieClip;
	import flash.events.*;
    import flash.text.*;//for textfield
	
	public class MainShooter extends MovieClip
	{
		var player:Gun;
		var t:Target;
		var points:int=0;
		var bArray:Array;//array of bullets
		var Score:TextField;
		var gameWin:TextField;
		var redBoldArial:TextFormat;//formatting text
		var lose:int=0;
		var speed:int=-1;
		var endless:Boolean=true;
		var playAgain:btnPlay;
		

		public function MainShooter()//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			player=new Gun();
			player.x=70;
			player.y=200;
			stage.addChild(player);
			
			playAgain=new btnPlay();
			playAgain.x=225;
			playAgain.y=50;
			
			
			//FORMATTING
			redBoldArial=new TextFormat();
			redBoldArial.size=28;
			redBoldArial.bold=true;
			redBoldArial.color=0xFF0000;//red colour
			
			//create the textfield
			Score=new TextField();
			Score.defaultTextFormat=redBoldArial;//applying the format
			Score.x=20;
			Score.y=20;
			Score.text=points.toString();
			stage.addChild(Score);
			
			gameWin=new TextField();
			gameWin.defaultTextFormat=redBoldArial;
			gameWin.width=150;
			gameWin.x=250;
			gameWin.y=200;
			
			t=new Target();
			t.x=450;
			t.y=Math.random()*400;
			stage.addChild(t);
			
			bArray=new Array();
	
			stage.addEventListener(Event.ENTER_FRAME,gameLoop);
			stage.addEventListener(MouseEvent.CLICK,fireBullet);
			
		}//end CONSTRUCTOR
		
		public function gameLoop(e:Event)//forever in scratch
		{
			player.y=mouseY;
			
			//we need to create a loop that will
			//move each bullet that is in the array
			for (var j:int=0;j<bArray.length;j++)
			{
				//for each bullet on the screen move it
				//10 pixels right if it is still visible
				if (bArray[j].x<560)
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
					
				}//end else
				
				//a new IF statement
				//check if one of the bullets hits the target
				if (t!=null && bArray[j]!=null && bArray[j].hitTestObject(t))
				{
					if (endless==false)
					{
						stage.removeChild(t);
						t=null;
					}
					else
					{
						t.y=Math.random()*400;
						t.x=550;
						speed+=-1;
						trace(speed);
						
					}
					
					stage.removeChild(bArray[j]);//1. from stage
					bArray.splice(j,1);//2. from the array
					
					points++;
					//updating score
					Score.text=points.toString();
					stage.addChild(Score);
					
				}
				
				
				
				
			}//end for
			
			t.x+=speed;//charging
			
			if (t.x<0)
			{
				lose+=1;
			}
			
			if (lose>1)
			{
				gameWin.text=("YOU LOSE");
				stage.addChild(gameWin);
				
				endless=false;
			}
			
			
			if (endless==false)
			{
				Score.text=("Good job! Score: "+points);
				Score.x=250;
				Score.y=100;
				Score.width=500;
				stage.addChild(Score);
				stage.addChild(playAgain);
				playAgain.addEventListener(MouseEvent.CLICK,resetGame);
			}
			
		}//end gameLoop
		
		public function fireBullet(e:MouseEvent)
		{
			//we need to add the bullet on the stage
			//also ADD the bullet to the array
			var b:Bullet;
			b=new Bullet();
			b.x=63;
			b.y=player.y;
			stage.addChild(b);//add to stage
			bArray.push(b);//add to the array
		}
		
		public function resetGame(e:MouseEvent):void
		{
			trace("I'm alive")
			t.x=550;
			lose=0;
			speed=-1;
			endless=true;
			points=0;
			stage.removeChild(gameWin);
			stage.removeChild(Score);
			Score=new TextField();
			Score.defaultTextFormat=redBoldArial;//applying the format
			Score.x=20;
			Score.y=20;
			Score.text=points.toString();
			stage.addChild(Score);
			endless=true;
			stage.removeChild(playAgain);
		}
		
	}//end class
}//end package