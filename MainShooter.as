package
{
	import flash.display.MovieClip;
	import flash.events.*;
	public class MainShooter extends MovieClip
	{
		var b:Bullet;
		var player:Gun;
		var hit:enemy;
		var bArray:Array;
		var t:ouch;
		

		public function MainShooter()//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			t=new ouch();
			t.x=300;
			t.y=300;
			
			player=new Gun();
			player.x=70;
			player.y=200;
			stage.addChild(player);
			
			hit=new enemy();
			hit.x=460;
			hit.y=200;
			stage.addChild(hit);
			
			bArray= new Array();
	
			stage.addEventListener(Event.ENTER_FRAME,gameLoop);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,playerMove);
			stage.addEventListener(MouseEvent.CLICK,bulletClick);
			
		}//end CONSTRUCTOR
		
		public function bulletClick (e:MouseEvent)
		{
			b=new Bullet();
			b.x=player.x;
			b.y=player.y;
			stage.addChild(b);
			bArray.push(b);
			trace(bArray);
			var d:int=0;
			
			stage.removeChild(t);

		}
		
		public function playerMove(e:MouseEvent)
		{
			player.y=mouseY;
		}
		
		public function gameLoop(e:Event)
		{
			for (var j:int=0;j<bArray.length;j++)
			{
				bArray[j].x+=5;
				if (bArray[j].x==hit.x && bArray[j].y<hit.y+40 && bArray[j].y>hit.y-40)
				{
					stage.addChild(t);
					
				}
			}
		}
	}//end class
}//end package