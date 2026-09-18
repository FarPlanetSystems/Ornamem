void fuehreRotationAus() {
    if (formen.size() == 0) {
    return;
  }
  
  if (!gabDrehung && !(gabSpiegelungQuer && gabSpiegelungLaengs)) {
    // Rotationsachse durch Mausposition bestimmt
    rotationsAchseX = 0;
    float cx;
      cx = height / 16; 
    System.out.println();
    float cy = height/2;
    // Abstand vom ersten Motiv zur Rotationsachse
    /*
    if (formen.size() > 0) { //gibt es überhaupt Motive?
      Form erstesMotiv = formen.get(0);
      rotationsHalbePeriode = abs(erstesMotiv.x - rotationsAchseX); 

      // Ganze Periode = zweimal halbe Periode
      periodenlaenge = 4 * rotationsHalbePeriode;
    }
    */
     int anzahl = formen.size();
  ArrayList<Form> neueMotive = new ArrayList<Form>();
  for (int i = 0; i < anzahl; i++) {
    int k = 0;
    Form m = formen.get(i);
    k = i / figAnzahl * figAnzahl;
    // 180° Rotation um die Rotationsachse
    float rotierterX = 0;
    float rotierterY = 0;
    rotierterX = 2 * (cx + formen.get(k).x) - m.x;
    rotierterY = 2 * cy - m.y;
    
    // Danach direkt um die GANZE
    // Periodenlänge nach rechts verschieben
    neueMotive.add(new Form(rotierterX,rotierterY,m.typ,!m.orientierung));
    gabDrehung = true;
  }
  // Die fertigen Motive hinzufügen
  formen.addAll(neueMotive);
  }
}
