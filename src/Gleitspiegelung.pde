public class Gleitspieg {
  int y;
  public Gleitspieg (int Y) {
    y = Y;
  }
}

void gleitspiegelung () {
  fill(255);
  textSize(24);
  text("MODUS 4: ertelle deine Gleitspiegelung", 20, 200);

  textSize(16);
  text("Klick = Gleichspiegelung", 20, 230);
  
}

void figurGleit (Gleitspieg gleit) {
  ArrayList<Form> gformen = new ArrayList<Form> ();
  for (Form f : formen) {
    Form temp = new Form(f.x + height / 4, 2*gleit.y - f.y, f.typ, !f.orientierung);
    gformen.add(temp);
  }
formen.addAll(gformen);
}
