class Planeta{
  private final String ruta_recursos = "texturas/";
  private float angulo_rotacion = 0;
  private final float v_rotacion;
  private final PImage img;
  private final PShape planeta;
  private float angulo;
  private final float velocidad_traslacion;
  private final float radio_orbita;
  private final float radio_planeta;
  Punto posicionRelativa = new Punto(0, 0, 0);
  
  public Planeta(String img_file, float angulo, float velocidad_traslacion, float radio_orbita, float radio_planeta, float v_rotacion){
    this.img = loadImage(ruta_recursos + img_file);
    this.radio_planeta = radio_planeta;
    this.planeta = createShape(SPHERE, this.radio_planeta);
    this.planeta.setTexture(this.img);
    this.angulo = angulo;
    this.velocidad_traslacion = velocidad_traslacion;
    this.radio_orbita = radio_orbita;
    this.v_rotacion = v_rotacion;
  }
  
  private float getAngulo(float anterior, float velocidad){
    float angulo = (anterior + velocidad) % TWO_PI;
    return angulo;
  }
  
  public void dibuja_planeta(){
    
    pushMatrix();
    
    this.angulo = getAngulo(this.angulo, this.velocidad_traslacion);
    this.posicionRelativa = new Punto(-this.radio_orbita * cos(this.angulo), 0, this.radio_orbita * sin(this.angulo));
    translate(-this.radio_orbita * cos(this.angulo), 0, this.radio_orbita * sin(this.angulo));
    
    pushMatrix();
    this.angulo_rotacion = getAngulo(this.angulo_rotacion, v_rotacion);
    rotateY(this.angulo_rotacion);
    shape(this.planeta);

    popMatrix();
    popMatrix();
    
  }

  Punto getPosicionRelativa(){
    return posicionRelativa;
  }
}
