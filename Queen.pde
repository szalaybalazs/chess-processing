class Queen extends Actor {
  public Queen(int x, int y, boolean white) {
    super(x, y, white);
  }
  
  public void setup() {
    img = loadImage(white ? "images/WhiteQueen.png" : "images/BlackQueen.png");
  }
}
