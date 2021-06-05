class Actor {
  int posX = 0;
  int posY = 0;
  int tileDimensions = 0;
  
  boolean white = false;
  
  PImage img;
  public Actor(int posX, int posY, boolean white) {
    super();
    this.posX = posX;
    this.posY = posY;
    this.white = white;
    setup();
  }
  
  public void setup() {
    img = loadImage(white ? "images/WhitePawn.png" : "images/BlackPawn.png");
  }
  
  public void setTileDimensions(int dimensions) {
    tileDimensions = dimensions;
  }
  
  public String[] getValidMoves() {
    return new String[0];
  }
  
  public void setPosition() {
  }
 
  public void draw() {
    imageMode(CENTER);
    image(img,posX * tileDimensions + tileDimensions / 2, posY * tileDimensions + tileDimensions / 2, tileDimensions, tileDimensions);
  }
}
