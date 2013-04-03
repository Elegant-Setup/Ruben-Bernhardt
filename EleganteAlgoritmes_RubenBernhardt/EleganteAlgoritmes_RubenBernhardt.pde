import ddf.minim.*;
Minim minim;
AudioInput in;
PImage vensterAlpha;
ArrayList<Blok> blokken = new ArrayList();
float timer;

void setup() {
    size(1000, 1000, P2D);
    colorMode(RGB, 255, 255, 255, 100);
    smooth();
    rectMode(CENTER);
    vensterAlpha = loadImage("vensterAlpha.png");
    
    minim = new Minim(this);
    minim.debugOn();
    
    in = minim.getLineIn(Minim.STEREO, 512);
    
    timer = 1800;
}

void draw() {
    background(255);
    noStroke();
    timer -= 1;
    float amplitude = 0;
  
    for(int i = 0; i < in.bufferSize() - 1; i++) {
      if (in.left.get(i) > amplitude) {
        amplitude = in.left.get(i);
      }
    }
  
    if (amplitude > 0.09
    ) {
       trigger(amplitude); 
    }
  
    for (Blok b:blokken) {
       fill(b.c);
       rect(b.x, b.y, b.w, b.h); 
    }
    
    imageMode(CENTER);
    translate(width/2, height/2);
    image(vensterAlpha, 0, 0);
    
    if (timer == 0) {
      saveFrame("VictoryBoogieWoogie-#####.jpeg");
      blokken.clear();
      timer = 1800;
    }
 }

void trigger(float amplitude) {
     Blok n = new Blok();
     n.x = width/2 + random(-320, 320);
     n.y = height/2 + random(-320, 320);
     n.w = amplitude+1*random(10,100);
     n.h = amplitude+1*random(10,100);
     n.c = randomColor();
     blokken.add(n);
}

color randomColor() {
      color rood = color(200, 0, 0);
      color geel = color(255, 220, 0);
      color blauw = color(0, 0, 200);
      color wit = color(255);
      color grijs = color(210);
      color c = color(0);

      color kleuren[] = { rood, geel, blauw, wit, grijs };
      
      return kleuren[int (random(0,5))];
}

void stop() {
      in.close();
      minim.stop();
      
      super.stop();
}
