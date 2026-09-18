
class Form {

  public float x;
  public float y;
  public int typ;
  public boolean orientierung;

  Form(float x, float y, int typ, boolean orientierung) {
    this.x = x;
    this.y = y;
    this.typ = typ;
    this.orientierung = orientierung;
  }
  // NORMALE DARSTELLUNG
  void anzeigen() {
    zeichneForm(x,y,orientierung);
    //System.out.println("form angezeigt");
  }
  // VORSCHAU
  void anzeigenVorschau(float xNeu,float yNeu,boolean rotationNeu) {
    fill(100, 100, 100);
    zeichneForm(xNeu,yNeu,rotationNeu);
    
  }
  // FORM ZEICHNEN
  void zeichneForm(float px,float py,boolean rot) {
    pushMatrix();
    translate(px, py);
    if (rot){
      rotate(PI);
    }
    //System.out.println("typ:"+typ);
    // KREIS
    if (typ == 1) {
      //System.out.println("Kreis angezeigt");
      ellipse(0,0,50,50);
    }
    // QUADRAT
    else if (typ == 2) {
      rectMode(CENTER);
      rect(0,0,50,50);
      rectMode(CORNER);
    }
    // DREIECK
    else if (typ == 3) {
      triangle(0,-30,-30,25,30,25);
    }
    popMatrix();
  }
  
}

void formenBauen() {
  fill(255);
  textSize(24);
  text("SCHRITT 1: Baue dein eigenes Motiv", 20, 200);
  textSize(16);
  text("Klick = Kreis", 20, 230);
  text("SHIFT + Klick = Quadrat", 20, 255);
  text("CTRL + Klick = Dreieck", 20, 280);
  rectMode(CORNER);  
  // Position und Größe 
  float fensterX = 30; float fensterY = 400; float fensterBreite = 470; float fensterHoehe = 480;
  // Hintergrund 
  fill(240); stroke(255); strokeWeight(4); rect( fensterX, fensterY, fensterBreite, fensterHoehe ); 
  // Beschriftung 
  fill(30); textSize(18); text( "DEIN ZEICHENBEREICH", fensterX + 20, fensterY + 30 );
}
