import damkjer.ocd.*;
//import gifAnimation.*;

//GifMaker ficherogif;

PImage img;

Planeta tierra;
Planeta luna;

float rotacionX = 0;
float rotacionY = 0;
float zoom = 0;
float zoomAcumulado = 0;
int cuenta_frames = 0;

boolean subir = false;
boolean bajar = false;
boolean girar_izquierda = false;
boolean girar_derecha = false;
boolean acercar = false;
boolean alejar = false;
boolean pausa = false;
boolean menu = true;

Camera camara;
float R;

void setup(){
  fullScreen(P3D);

  //ficherogif = new GifMaker( this, "Lighting_3D.gif");
  //ficherogif.setRepeat(0);

  img = loadImage("texturas/muro.jpg");
  
  R = 1000;
  camara = new Camera(this, width/2, height/2, R, width/2, height/2, 0);
  
  noStroke();
  noFill();
  textAlign(CENTER, TOP);
  
  tierra = new Planeta("tierra.jpg", 0, 0, 0, 100, PI/256);
  luna = new Planeta("luna.jpg", random(0, TWO_PI), PI/256, 200, 25, PI/128);
  
}

void actualizar_perspectiva(){
  
  if(!menu){
    
    if(!subir && !bajar){
      rotacionX = 0;
    }else{
      if(subir){
        rotacionX = -PI/512;
      }
      
      if(bajar){
        rotacionX = PI/512;
      }
    }
    
    if(!girar_derecha && !girar_izquierda){
      rotacionY = 0;
    }else{
      if(girar_derecha){
        rotacionY = PI/512;
      }
      
      if(girar_izquierda){
        rotacionY = -PI/512;   
      }
    }
    
    if(!acercar && !alejar){
      zoom = 0;
    }else{
      if(acercar){
        zoom = -PI/512;
        zoomAcumulado += zoom;
      }
      
      if(alejar){
        zoom = PI/512;
        zoomAcumulado += zoom;
      }
    }  
    
  }else{
    rotacionX = 0;
    rotacionY = 0;
    zoom = 0;
  }
  
}

void dibujaSistemaTierraLuna(){

  pushMatrix();
  
  translate(width/2, height/2, 0);
  
  tierra.dibuja_planeta();
  luna.dibuja_planeta();

  actualizar_perspectiva();
  
  popMatrix();
}

void dibujaCubo(){
  pushMatrix();
  
  translate(width/2, height/2);
  
  textureMode(NORMAL);
  textureWrap(REPEAT);
  
  beginShape();
  texture(img);
  vertex(-400, 300, 400, 0, 0);
  vertex(-400, 300, -400, 4, 0);
  vertex(400, 300, -400, 0, 4);
  vertex(400, 300, 400, 4, 4);
  endShape();
  
  beginShape();
  texture(img);
  vertex(-400, -300, 400, 0, 0);
  vertex(-400, -300, -400, 4, 0);
  vertex(-400, 300, -400, 0, 4);
  vertex(-400, 300, 400, 4, 4);
  endShape();
  
  beginShape();
  texture(img);
  vertex(400, -300, 400, 0, 0);
  vertex(400, -300, -400, 4, 0);
  vertex(400, 300, -400, 0, 4);
  vertex(400, 300, 400, 4, 4);
  endShape();
  
  beginShape();
  texture(img);
  vertex(-400, -300, 400, 0, 0);
  vertex(-400, -300, -400, 4, 0);
  vertex(400, -300, -400, 0, 4);
  vertex(400, -300, 400, 4, 4);
  endShape();
  
  popMatrix();
  
}

void imprimeMenu(){
  
  int posX = (int)(1.75 * (width/5));
  int posY = height/3;
  
  camara.jump(width/2, height/2, R);
  camara.zoom(-zoomAcumulado);
  
  zoomAcumulado = 0;
  
  pushMatrix();
  
  translate(0, 0, 300);
  
  fill(230, 10, 30);
  rect(posX, posY, 1.5 * width/5, height/3, 10);
  
  fill(255);
  strokeWeight(3);
  
  textFont(createFont("Arial", 30));
  textAlign(CENTER, CENTER);
  
  text("Lighting 3D", width/2, posY + 30);
 
  textAlign(LEFT, CENTER);
  textFont(createFont("Arial", 20));
  text("Rotar la cámara derecha/izquierda: flechas derecha/izquerda", posX + 20, posY + 80);
  text("Rotar la cámara arriba/abajo: flechas arriba/abajo", posX + 20, posY + 110);
  text("Hacer zoom: ampliar tecla a, alejar tecla s", posX + 20, posY + 140);
  text("Modificar la luz de ambiente: mover ratón derecha/izquierda", posX + 20, posY + 170);
  text("Modificar la emision de luz: mover ratón arriba/abajo", posX + 20, posY + 200);
  text("Mostrar/Ocultar menú: tecla m", posX + 20, posY + 230);
  text("Pausar: tecla espacio", posX + 20, posY + 260);
  text("Salir: Escape", posX + 20, posY + 290);
  
  popMatrix();
  
  strokeWeight(0);
  noFill();
}

void ilumina(){
  
  directionalLight(255, 255, 255, -1, -0.2, 0.2);
 
  float val_ambiente_rojo = (float)(width/2 - mouseX) / ((float)width/2) * 255;
  float val_ambiente_azul = 0;
  
  if(val_ambiente_rojo < 0){
    val_ambiente_azul = -val_ambiente_rojo;
    val_ambiente_rojo = 0;
  }
  
  ambientLight((int)val_ambiente_rojo, 0 , (int)val_ambiente_azul);
  
  Punto pos_luna = luna.getPosicionRelativa();
  spotLight(255, 255, 0, pos_luna.getX() + width/2, pos_luna.getY() + height/2, pos_luna.getZ(), -1, -0.2, 0.2, PI/16, 100);

  float val_emissive = (float)abs(height/2 - mouseY) / ((float)height/2) * 255;
  emissive(0, val_emissive, 0); 
  
  shininess(100.0);  
  
}

void actualizaCamara(){
  camara.feed();
  camara.arc(rotacionX);
  camara.circle(rotacionY);
  camara.zoom(zoom);
}

void draw(){
  
  background(0);
  
  if(menu){
     
    imprimeMenu();
    
  }
  
  ilumina();
  actualizaCamara();
  
  dibujaSistemaTierraLuna();
  dibujaCubo();

  //if(cuenta_frames == 10){
  //  ficherogif.addFrame();
  //  cuenta_frames = 0;
  //}
  
  //cuenta_frames++;
}


void keyPressed(){
  
  if (key == CODED && keyCode == UP) {
    subir = true;  
  }
  
  if (key == CODED && keyCode == DOWN) {
    bajar = true;
  }
  
  if (key == CODED && keyCode == LEFT) {
    girar_izquierda = true;  
  }
  
  if (key == CODED && keyCode == RIGHT) {
    girar_derecha = true;
  }
  
  if (key == 'a' || key == 'A') {
    acercar = true;  
  }
  
  if (key == 's' || key == 'S') {
    alejar = true;
  }

  if (key == 'm' || key == 'M') {
    if(menu){
      menu = false;
    }else{
      menu = true;
    }
  }
  
  if (key == ' '){
    if(!pausa){
      pausa = true;
      noLoop();
    }else{
      pausa = false;
      loop();
    }
  }
  
  //if(key == 'r'){
  //  ficherogif.finish();
  //}
  
}

void keyReleased(){
  
  if (key == CODED && keyCode == UP) {
    subir = false;  
  }
  
  if (key == CODED && keyCode == DOWN) {
    bajar = false;
  }
  
  if (key == CODED && keyCode == LEFT) {
    girar_izquierda = false;
  }
  
  if (key == CODED && keyCode == RIGHT) {
    girar_derecha = false;
  }
  
  if (key == 'a' || key == 'A') {
    acercar = false;  
  }
  
  if (key == 's' || key == 'S') {
    alejar = false;
  }

}
