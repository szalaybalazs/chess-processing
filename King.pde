class King extends Actor {
  public King(int x, int y, boolean white) {
    super(x, y, white);
  }
  
  public void setup() {
    img = loadImage(white ? "images/WhiteKing.png" : "images/BlackKing.png");
  }
}
