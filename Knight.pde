class Knight extends Actor {
  public Knight(int x, int y, boolean white) {
    super(x, y, white);
  }
  
  public void setup() {
    img = loadImage(white ? "images/WhiteKnight.png" : "images/BlackKnight.png");
  }
}
