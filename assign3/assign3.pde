  
final int GAME_START   = 0;
final int GAME_PLAYING = 1;
final int GAME_WIN     = 2;
final int GAME_LOSE    = 3;
int gameState = 0 ; 

final int WAVE1 = 0;
final int WAVE2 = 1;
final int WAVE3 = 2;
int waveState = 0;

int health = 0 ;

PImage start1 ;
PImage start2 ;
PImage end1 ;
PImage end2 ;

PImage fighter ; 
PImage enemy ; 
PImage treasure ; 
PImage background1 ; 
PImage background2 ;
PImage hp ;




float background1X ;
float background2X ;
float backgroundSpeed = 1 ; 

float treasureX = 0 ;
float treasureY = 0 ; 

float flightX = 0 ;
float flightY = 0 ;
float flightSpeed = 4 ;

float leaderEnemyX1 = 0 ;
float leaderEnemyY1 = 0 ;
float leaderEnemyX2 = 0 ;
float leaderEnemyY2 = 0 ;
float leaderEnemyX3 = 0 ;
float leaderEnemyY3 = 0 ;
float enemyX = 0 ;
float enemyY = 0 ; 

float enemyXSpeed = 5 ;
float enemyYSpeed = 0 ;
float enemyYSpeedAlpha = 0.1 ; 
 

boolean isMovingUp ;
boolean isMovingDown ;
boolean isMovingLeft ;
boolean isMovingRight ;





void setup () {
  
  size(640, 480) ;
  textAlign(CENTER);

  fighter    = loadImage("img/fighter.png"); 
  enemy      = loadImage("data/img/enemy.png"); 
  treasure   = loadImage("data/img/treasure.png"); 
  background1 = loadImage("data/img/bg1.png");
  background2 = loadImage("data/img/bg2.png");
  hp = loadImage("data/img/hp.png");
  
  start1 = loadImage("data/img/start1.png");
  start2 = loadImage("data/img/start2.png");
  end1 = loadImage("data/img/end1.png");
  end2 = loadImage("data/img/end2.png");
  
  

  background1X = -640 ; 
  background2X = 0 ;

  treasureX   = random(width  - treasure.width) ; 
  treasureY   = random(height - treasure.height) ; 

  leaderEnemyX1      = 0   ;   
  leaderEnemyY1      = random(height - enemy.height);
  leaderEnemyX2      = 0   ;   
  leaderEnemyY2      = random(height - 5*enemy.height+80);
  leaderEnemyX3      = 0   ;   
  leaderEnemyY3      = random(2*enemy.height,height - 3*enemy.height);
    
  flightX     = 580 ;
  flightY     = height/2 - fighter.height/2 ;
  
  health      = 100 ;
  gameState   = GAME_START ;
}

void draw() {
  
  switch(gameState){
      
    case GAME_START:
      if (mouseX > 200 && mouseX < 470 && 
          mouseY > 370 && mouseY < 420){
          gameState= (mousePressed) ? GAME_PLAYING : GAME_START ;
          image(start1,0,0);
      }else {
          image(start2,0,0) ;
      }
      
      
      break;
    
    case GAME_PLAYING:
      background(0);
      
      // scrolling background 
      background1X += backgroundSpeed ;
      background2X += backgroundSpeed ;
      
      if (background1X > 640) background1X = -640 ; 
      if (background2X > 640) background2X = -640 ;
      
      image(background1 , background1X, 0);
      image(background2 , background2X, 0);
      
      // make treasure
      //image(treasure, treasureX, treasureY);
      
      // fighter movement
      //if (isMovingUp    && flightY > 0 )                      flightY -= flightSpeed ;  
      //if (isMovingDown  && flightY + fighter.height < height) flightY += flightSpeed ;
      //if (isMovingRight && flightX + fighter.width < width)   flightX += flightSpeed ;
      //if (isMovingLeft  && flightX > 0 )                      flightX -= flightSpeed ;
      //image(fighter, flightX , flightY) ;
      
      // enemy movement
    
      switch(waveState){
        //wave1
        case WAVE1:
         // leaderEnemyY1      = random(height - enemy.height);
          enemyYSpeed = 0 ;
          leaderEnemyX1 += enemyXSpeed ;
      
          for(float i=0 ; i<5 ; i++){
            enemyX = leaderEnemyX1 - i*(enemy.width +20) ;
            enemyY = leaderEnemyY1 ;
            image(enemy, enemyX , enemyY  ) ;
          }
         
          if (enemyX >= width +enemy.width){
            leaderEnemyX1 = 0 ;
            leaderEnemyY1      = random(height - enemy.height);
            waveState = WAVE2 ;
          }
         
          break;
      
        //wave2
        case WAVE2: 
         // leaderEnemyY2      = random(height - 5*enemy.height+80);
          enemyYSpeed = 0 ;
          leaderEnemyX2 += enemyXSpeed ;
      
           for(float i=0 ; i<5 ; i++){
             enemyX = leaderEnemyX2 - i*(enemy.width+20) ;
             enemyY = leaderEnemyY2 + i*(enemy.height-20) ;
             image(enemy, enemyX , enemyY  ) ;
           }
           
           if(enemyX >= width +enemy.width){
             leaderEnemyX2 = 0 ;
             leaderEnemyY2      = random(height - 5*enemy.height+80);
             waveState = WAVE3 ;
           }
           
           break;
       
       //wave3
       case WAVE3:  
        // leaderEnemyY3      = random(2*enemy.height,height - 3*enemy.height);
         enemyYSpeed = 0 ;
         leaderEnemyX3 += enemyXSpeed ;
        
         for(float i=0 ; i<3 ; i++){
           enemyX = leaderEnemyX3 - i*(enemy.width) ;
           enemyY = leaderEnemyY3 - i*(enemy.height) ;
           image(enemy, enemyX , enemyY  ) ;
         }
          
         for(float i=0 ; i<3 ; i++){
           enemyX = leaderEnemyX3 - i*(enemy.width) ;
           enemyY = leaderEnemyY3 + i*(enemy.height) ;
           image(enemy, enemyX , enemyY  ) ;
         }
         
         for(float i=3 ; i<4 ; i++){
           enemyX = leaderEnemyX3 - i*(enemy.width) ;
           enemyY = leaderEnemyY3 + (4-i)*(enemy.height) ;
           image(enemy, enemyX , enemyY  ) ;
         }
         
         for(float i=3 ; i<5 ; i++){
           enemyX = leaderEnemyX3 - i*(enemy.width) ;
           enemyY = leaderEnemyY3 - (4-i)*(enemy.height) ;
           image(enemy, enemyX , enemyY  ) ;
         }
         
         if(enemyX>=width +enemy.width){
           leaderEnemyX3 = 0 ;
           leaderEnemyY3      = random(2*enemy.height,height - 3*enemy.height);
           waveState = WAVE1;
         }
         
         break;
     }
        
       
      
      // health
      fill (255,0,0) ;
      rect(15,10,health * 2 , 20 ) ;
      image(hp,10,10);
      
      
      
        

      break;
        
    case GAME_LOSE:
      if (mouseX > 200 && mouseX < 470 && 
          mouseY > 300 && mouseY < 360){
          gameState= (mousePressed) ? GAME_PLAYING : GAME_LOSE ;
          image(end1,0,0);
      }else {
          image(end2,0,0) ;
      }
      
      // init variables before restart the game
      treasureX   = random(width  - treasure.width) ; 
      treasureY   = random(height - treasure.height) ; 
    
      enemyX      =        width  + enemy.width   ;   
      enemyY      = random(height - enemy.height);
        
      flightX     = 580 ;
      flightY     = height/2 - fighter.height/2 ;

      health      = 100 ;
    
      
      break;
      
    default : 
    
      
      
      break ;
  }
  
  
  
  
  
  
}


void keyPressed(){
  switch(keyCode){
    case UP : isMovingUp = true ;break ;
    case DOWN : isMovingDown = true ; break ;
    case LEFT : isMovingLeft = true ; break ;
    case RIGHT : isMovingRight = true ; break ;
    default :break ;
  }
  

  
}
void keyReleased(){
  switch(keyCode){
    case UP : isMovingUp = false ;break ;
    case DOWN : isMovingDown = false ; break ;
    case LEFT : isMovingLeft = false ; break ;
    case RIGHT : isMovingRight = false ; break ;
    default :break ;
  }
  
  if (key == ENTER) {
    switch(gameState) {
      case GAME_START:
      case GAME_LOSE:
        gameState = GAME_PLAYING;
      default : break ;
    }
  }
}
