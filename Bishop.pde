class Bishop extends Actor {
  public Bishop(int x, int y, boolean white) {
    super(x, y, white);
  }
  
  public void setup() {
    img = loadImage(white ? "images/WhiteBishop.png" : "images/BlackBishop.png");
  }
}
