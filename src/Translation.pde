float verschiebungLaenge = height/2;

void translation () {
fill(255);
  textSize(24);
  text("MODUS 5: Translation", 20, 200);

  textSize(16);
  text("Klick = um 200px verschieben", 20, 230);
}

void verschieben(){
  //System.out.println("laenge:" + height/2);
//ArrayList<Form> nformen = new ArrayList<Form> ();
for (int i = -1; i < 8; i++) {
    for (Form f : formen) {
      Form temp = new Form(f.x + height/2 * i, f.y, f.typ, f.orientierung);
      temp.anzeigen();
    } 
}
}

void fuehreTranslationAus() {
  int anzahl = formen.size();

  ArrayList<Form> neueFormen = new ArrayList<Form>();

  for (int i = 0; i < anzahl; i++) {

    Form m = formen.get(i);

    neueFormen.add(new Form(m.x + dx,m.y + dy,m.typ,m.orientierung));
  }

  formen.addAll(neueFormen);
}
