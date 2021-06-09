// Actor move
class Move {
  Move effect;

  // Source actor
  public Actor source;
  
  // Target actor
  public Actor target;

  // Target position
  public int x;
  public int y;

  // Creating move
  public Move(int x, int y, Actor target) {
    this.target = target;
    this.x = x;
    this.y = y;
  }
}

int currentMove = 1;


class Actor {
  // Unique id of actor
  public int id;

  // Position of actor
  public int posX = 0;
  public int posY = 0;

  // The forward direction of the actor, depends on color
  public int direction = 0;

  // Store number of moves per actor
  int numberOfMoves = 0;
  int previousMove = 0;

  // Stored moves
  ArrayList<Move> previousMoves = new ArrayList<Move>();

  // The tile dimensions of renderer
  int tileDimensions = 0;
  
  // Whether actor is white or black
  boolean white = false;
  public Player player;
  public Player opponent;
  
  // Image of actor
  PImage img;

  public String name = "Pawn";
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

  public Actor(int posX, int posY) {
    super();
    
    // Storing initial position and color
    this.posX = posX;
    this.posY = posY;
    
    // This is bad practise, should use either static auto incrementation on uuid
    this.id = (int)(random(1000) * 1000.0);
  }

  public void setColor(boolean white) {
    // Setting forward direction
    direction = white ? -1 : 1;
    this.white = white;
  }

  public void setPlayer(Player player, Player oppponent) {
    this.player = player;
    this.opponent = oppponent;
  }
  
  // Seup actor
  public void setup() {
    String colorName = white ? "White" : "Black";
    img = loadImage("images/" + colorName + name + ".png");
  }
  
  // Saving tile dimensions
  public void setTileDimensions(int dimensions) {
    tileDimensions = dimensions;
  }

  // Check if an other actor is ally
  public boolean isAlly(Actor actor) {
    if (actor == null) return false;
    return actor.white == this.white;
  }
  
  // Generated all available moves
  public ArrayList<Move> getAvailableMoves(Board board) {
    // Return empty array
    return new ArrayList<Move>();
  }

  // Generate all, checked moves
  public ArrayList<Move> getAllMoves(Board board) {
    ArrayList<Move> moves = getAvailableMoves(board);
    for (int i = moves.size() - 1; i >= 0; i--) {
      Move move = moves.get(i);
      if (move.x < 0 || move.x > 7) moves.remove(i);
      else if (move.y < 0 || move.y > 7) moves.remove(i);
      else if (!checkForCheckSolution(board, move)) moves.remove(i);
    }
    return moves;
  }

  // Move actor to new location
  // This is where animation would happen
  public Actor moveTo(Move move) {
    previousMoves.add(move);
    previousMove = currentMove;
    numberOfMoves++;
    currentMove++;
    setPosition(move.x, move.y);
    return this;
  }
  
  // Set the position of the actor
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

  // Return if actor is in danger (only used by kings)
  public boolean isInDanger(Board board) {
    return false;
  }

  // Check if actor is in danger (only used by kings)
  public void checkForDanger(Board board) {}

  // Check if move is a check solution
  public boolean checkForCheckSolution(Board board, Move move) {
    boolean result = false;
    int prevX = this.posX;
    int prevY = this.posY;
    
    this.posX = move.x;
    this.posY = move.y;
    
    if (move.target != null) opponent.removeActor(move.target);
    ArrayList<Move> moves = player.generateAttackedfields(board);
    result = player.checkSolution(moves);
    if (move.target != null) opponent.addActor(move.target);
    
    this.posX = prevX;
    this.posY = prevY;

    return !result;
  }
}
