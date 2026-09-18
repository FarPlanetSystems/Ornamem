int modus = 1;


boolean gabSpiegelungQuer = false;
boolean gabSpiegelungLaengs = false;
int spiegelungLaengsY = 0;
boolean gabDrehung = false;
boolean gabGleitspiegelung = false;
boolean formenHinzugefuegt = false;

float dx = 100;
float dy = 0;
float gleitweg = 100;
boolean horizontalSpiegelung = true;
boolean shiftHeld = false;
boolean ctrlHeld = false;
// Diese Variablen gibt es NUR hier!
float rotationsAchseX = 0;
float rotationsHalbePeriode = 0;
float periodenlaenge = 200;


ArrayList<Form> formen = new ArrayList<Form>();
void setup () {
  fullScreen(); 
  smooth(8); 
  textFont(createFont("Arial", 16));
}

void mousePressed() {
    switch (modus){
     case 1:
       bearbeiteFigurangabe();
       break;
      case 2:
        bearbeiteSpiegelungangabe();
        break;
      case 3:
        bearbeiteGleitspiegelung();
        break;
      case 4:
        fuehreRotationAus();
   }
}

void keyPressed() {

  switch (key){
    case '1':{
      modus =1;
      break;
    }
    case '2':{
      modus =2;
      formenHinzugefuegt = true;
      break;
    }
    case '3':{
      modus = 3;
      formenHinzugefuegt = true;
      break;
    }
    case '4':{
      modus =4;
      formenHinzugefuegt = true;
      break;
    }
    case 'r':{
      formen.clear();
      formenHinzugefuegt = false;
       gabSpiegelungQuer = false;
       gabSpiegelungLaengs = false;
       gabDrehung = false;
       gabGleitspiegelung = false;
       horizontalSpiegelung = true;
       shiftHeld = false;
       ctrlHeld = false;
      break;
    }
    default:
    break;
  }
  // Modifier
  if (keyCode == SHIFT) {
    shiftHeld = true;
  }

  if (keyCode == CONTROL) {
    ctrlHeld = true;
  }
  // Spiegelungsrichtung
  if (modus == 2) {

    if (key == 'h' || key == 'H') {
      horizontalSpiegelung = true;
      System.out.println("H gedruekt");
    }

    if (key == 'v' || key == 'V') {
      horizontalSpiegelung = false;
      System.out.println("V gedruekt");
    }
  }
}

void draw () {
  background(255);
  zeichneBand();
  // Bereits gesetzte Formen
  

  // Vorschau
  if (formen.size() > 0) {
    if (modus == 2) {
      zeichneSpiegelungsVorschau();
    }
    if (modus == 3) {
      zeichneGleitspiegelungVorschau();
    }
    if (modus == 4) {
      zeichneRotationVorschau();
    }
  }

  // Achsen
  if (modus >= 2 && modus <= 4) {
    zeichneAchsen();
  }

  // UI
  zeichneUI();
  
  renderOrnament();
 
  
  
  
//für das UserInterface:

  fill(255);
  textSize(18);
  text("1 = Formen bauen", 20, 30);
  text("2 = Spiegelung", 20, 55);
  text("3 = Rotation", 20, 80);
  text("4 = Gleitspiegelung", 20, 105);
  text("Leertaste = Formen löschen", 20, 155);
}

void renderOrnament(){
   for (Form m : formen) {
    m.anzeigen();
 }
   verschieben();
}

int figAnzahl = 0;

void bearbeiteFigurangabe(){
  if (!formenHinzugefuegt){
    
      float rand = 30; 
      if (modus == 1) {
    // Größe des Zeichenfensters 
        float fensterX = 0; 
        float fensterY = height/4; 
        float fensterBreite = height/4; 
        float fensterHoehe = height/4;
        if (mouseX >= fensterX + rand && 
        mouseX <= fensterX + fensterBreite - rand && 
        mouseY >= fensterY + rand && 
        mouseY <= fensterY + fensterHoehe - rand) { 
          int form = 1;

          if (shiftHeld) {
            form = 2;
          }

          if (ctrlHeld) {
            form = 3;
          }

    formen.add(
      new Form(mouseX, mouseY, form, true)
    );
    System.out.println("form hinyugefyegt");
    figAnzahl++;
  }
      }
  }
  } 


void bearbeiteGleitspiegelung(){
  if(!gabGleitspiegelung && !gabSpiegelungLaengs){
    Gleitspieg gleitspieg = new Gleitspieg (0);
  gleitspieg.y = height/2;
  figurGleit(gleitspieg);
  for (Form f : formen) {
    f.anzeigen();
  }
  }
  gabGleitspiegelung = true;
  
}

void bearbeiteSpiegelungangabe(){
      int leng = formen.size();
      //bearbeite Spiegelung quer
      if (!horizontalSpiegelung && gabSpiegelungQuer == false) {
        System.out.println("horizontal gespiegelt");
        for (int i = 0; i < leng; i++){
          Form figur = formen.get(i);
          Form neuFigur = new Form(height/2- figur.x, figur.y, figur.typ, figur.orientierung);
          formen.add(neuFigur);
        }
        gabSpiegelungQuer = true;
       //bearbeite Spiegelung laengs
      }else if (!gabSpiegelungLaengs && !gabGleitspiegelung)
      {  
          System.out.println("vertical gespiegelt");
          spiegelungLaengsY = height/2;
          for (int i = 0; i < leng; i++){
          Form figur = formen.get(i);
          Form neuFigur = new Form(figur.x, 2*spiegelungLaengsY - figur.y, figur.typ, !figur.orientierung);
          formen.add(neuFigur);
        }
        gabSpiegelungLaengs = true;
        spiegelungLaengsY = 0;
    }   
}


// ================================
// TASTEN LOSLASSEN
// ================================

void keyReleased() {

  if (keyCode == SHIFT) {
    shiftHeld = false;
  }

  if (keyCode == CONTROL) {
    ctrlHeld = false;
  }
}

// ================================
// BAND
// ================================

void zeichneBand() {

  noFill();
  stroke(220);
  strokeWeight(1);

  rect(
    0,
    height * 0.25,
    width,
    height * 0.5
  );
}


// ================================
// ACHSEN
// ================================

void zeichneAchsen() {

  stroke(180);
  strokeWeight(2);

  // Horizontale Achse
  if (modus == 2 || modus == 3 ||
      (modus == 4 && !gabDrehung)) {

    line(
      0,
      height / 2.0,
      width,
      height / 2.0
    );
  }

  // Vertikale Spiegelungsachse
  if (modus == 2 && !horizontalSpiegelung) {

    line(
      height/4,
      0,
      height/4,
      height
    );
  }

  // Rotationsachse
  if (modus == 4 && !gabDrehung) {
    stroke(120);
    strokeWeight(10);
    point(height/4, height/2);
  }
}
// ================================
void zeichneTranslationVorschau() {
  for (Form m : formen) {m.anzeigenVorschau(m.x + dx,m.y + dy,m.orientierung);
  }
}
// GLEITSPIEGELUNG VORSCHAU
void zeichneGleitspiegelungVorschau() {
  float achseY = height / 2.0;
  for (Form m : formen) {m.anzeigenVorschau(m.x + height / 4, 2 * achseY - m.y,!m.orientierung);
  }
}

// ================================
void zeichneRotationVorschau() {

  // Erste Aktion:
  // 180° Rotation um Mausposition
  if (!gabDrehung && !(gabSpiegelungQuer && gabSpiegelungLaengs)) {
    float cx = height / 16;
    float cy = height / 2.0;
    int c = 0;
    int k1 = 0;
    for (Form m : formen) {
      k1 = c / figAnzahl * figAnzahl;
      float xNeu = 2 * (cx + formen.get(k1).x) - m.x;
      float yNeu = 2 * cy - m.y;
      m.anzeigenVorschau(xNeu,yNeu,!m.orientierung);
      c++;
    }
  }
}

// SPIEGELUNG VORSCHAU
void zeichneSpiegelungsVorschau() {
  // Horizontal
  if (horizontalSpiegelung) {
    float achseY = height / 2.0;
    for (Form m : formen) {m.anzeigenVorschau(m.x,2 * achseY - m.y,!m.orientierung);
    }
  }

  // Vertikal
  else {
    float achseX = height/4;
    for (Form m : formen) {m.anzeigenVorschau(2 * achseX - m.x,m.y,m.orientierung);
    }
  }
}

// =====================================================================
// USER INTERFACE
void zeichneUI() {
  fill(255, 235);
  noStroke();
  rect(20,20,620,170,10);
  fill(0);
  textSize(18);
  text("BANDORNAMENT",40,48);
  textSize(14);
  text("1 Formen | 2 Spiegelung | 3 Gleitspiegelung",40,75);
  text("4 Rotation 180° | R Reset",40,98);
  // Formen
  if (modus == 1) {
    text("Klick = Kreis | Shift + Klick = Quadrat | Strg + Klick = Dreieck",40,125);
      // Position und Größe 
    float fensterX = 0; float fensterY = height * 0.25; float fensterBreite = height/4; float fensterHoehe = height/4;
    // Hintergrund 
    fill(240); rect( fensterX, fensterY, fensterBreite, fensterHoehe ); 
    // Beschriftung 
    fill(30); textSize(18); text( "DEIN ZEICHENBEREICH", fensterX + 20, fensterY + 30 );
  }
  

  // Spiegelung
  if (modus == 2) {
    text("Modus 2: Spiegelung Klick = Spiegelung",40,148);
    text("H = horizontal | V = vertikal",40,125);
  }
  // Gleitspiegelung
  if (modus == 3) {
    text("Modus 3: Gleitspiegelung",40,125);
  }

  // Rotation
  if (modus == 4) {
     text("Modus 4: Rotation, Klick = Rotation",40,125);
     text("Danach wird die Periodenlänge automatisch verwendet.",40,148);
    
  }
}
