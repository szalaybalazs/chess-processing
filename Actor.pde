class Move {
  public Actor target;
  public int x;
  public int y;
  public Move(int x, int y, Actor target) {
    this.target = target;
    this.x = x;
    this.y = y;
  }
}

class Actor {
  // Unique id of actor
  public int id;

  // Position of actor
  public int posX = 0;
  public int posY = 0;

  public int direction = 0;

  // Stored moves
  ArrayList<Move> previousMoves = new ArrayList<Move>();

  // The tile dimensions of renderer
  int tileDimensions = 0;
  
  // Whether actor is white or black
  boolean white = false;
  
  // Image of actor
  PImage img;

  public String imageName = "Pawn";
  public Actor(int posX, int posY, boolean white) {
    super();
    
    // Storing initial position and color
    this.posX = posX;
    this.posY = posY;
    this.white = white;

    // Setting forward direction
    direction = white ? -1 : 1;
    
    // This is bad practise, should use either static auto incrementation on uuid
    this.id = (int)(random(1000) * 1000.0);
  }
  
  public void setup() {
    String colorName = white ? "White" : "Black";
    img = loadImage("images/" + colorName + imageName + ".png");
  }
  
  // Saving tile dimensions
  public void setTileDimensions(int dimensions) {
    tileDimensions = dimensions;
  }

  public boolean isAlly(Actor actor) {
    if (actor == null) return false;
    return actor.white == this.white;
  }
  
  public ArrayList<Move> getAvailableMoves(Board board) {
    ArrayList<Move> moves = new ArrayList<Move>();

    return moves;
  }

  public void storeTake(Actor actor) {
    // TODO: store take
  }

  public void moveTo(Move move) {
    previousMoves.add(move);
    setPosition(move.x, move.y);
  }
  
  public void setPosition(int x, int y) {
    posX = x;
    posY = y;
  }
 
  // Drawing actor
  public void draw(boolean selected) {
    // Calculating pixel positions
    int x = posX * tileDimensions;
    int y = posY * tileDimensions;

    // Checking if actor is selected
    if (selected) {
      fill(200, 200, 0, 100);
      rect(x, y, tileDimensions, tileDimensions);
    }

    // Drawing actor's image
    imageMode(CENTER);
    image(img, x + tileDimensions / 2, y + tileDimensions / 2, tileDimensions, tileDimensions);
  }
}
