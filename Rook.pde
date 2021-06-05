class Rook extends Actor {
  public Rook(int x, int y, boolean white) {
    super(x, y, white);
  }
  
  public void setup() {
    img = loadImage(white ? "images/WhiteRook.png" : "images/BlackRook.png");
  }
}
