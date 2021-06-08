class Board {
  // Dimensions
  private int dim = 0;
  private int tileDimensions = 0;

  public Player whitePlayer = new Player(true);
  public Player blackPlayer = new Player(false);

  // Store selected actor and selection state
  private boolean selection = false;
  Actor selectedActor;
  
  // Store current player
  private boolean currentPlayerIsWhite = true;

  // Available moves
  ArrayList<Move> moves = new ArrayList<Move>();

  // Game of the board
  Game game;

  // Add game to the board
  public void setGame(Game game) {
    this.game = game;
  }

  // Setup board
  public void setup(int dimensions) {
    dim = dimensions;
    tileDimensions = dimensions / 8;
    whitePlayer.setTileDimensions(tileDimensions);
    blackPlayer.setTileDimensions(tileDimensions);
  }

  // Set up player actors
  public void setupActors() {
    whitePlayer.setupActors();
    blackPlayer.setupActors();
  }

  // Get any actor
  public Actor getActor(int x, int y) {
    Actor actor;
    actor = whitePlayer.getActor(x, y);
    if (actor != null) return actor;
    return blackPlayer.getActor(x, y);
  }

  // Draw hoverable rect
  private void drawCheck(int x, int y) {
    boolean isWhite = (x + y) % 2 == 1;

    if (isWhite) drawRect(x, y, 239, 239, 239);
    else drawRect(x, y, 194, 215, 226);
  }

  // Draw opaque rect
  private void drawRect(int x, int y, int r, int g, int b) { drawRect(x, y, r, g, b, 255); }

  // Draw rect
  private void drawRect(int x, int y, int r, int g, int b, int a) {
    int posX = tileDimensions * x;
    int posY = tileDimensions * y;
    
    fill(r, g, b, a);
    rect(posX, posY, tileDimensions, tileDimensions);
  }

  // Handle clicks
  public void mouseClicked() {
    int x = (int)(((float)mouseX / 800.0) * 8);
    int y = (int)(((float)mouseY / 800.0) * 8);

    Actor actor = getActor(x, y);
    // Check if selected field has an actor & select it if so
    if (actor != null && !selection && actor.white == currentPlayerIsWhite) {
      selectedActor = actor;
      moves = actor.getAllMoves(this);
      selection = true;
    } else if (selection && selectedActor != null) {
      
      // Check if selected field is a valid move
      Move move = null;
      int i = 0;
      while(move == null && i < moves.size()) {
        Move _move = moves.get(i);
        if (_move.x == x && _move.y == y) move = _move;
        i++;
      }

      // If selection is a valid move, move actor, execute takes, and check for checks and stalemates
      if (move != null) {
        currentPlayerIsWhite = !currentPlayerIsWhite;
        if (move.target != null) selectedActor.opponent.removeActor(move.target);
        selectedActor.player.moveActor(selectedActor, move);

        Player activePlayer = currentPlayerIsWhite ? whitePlayer : blackPlayer;
        ArrayList<Move> availableMoves = activePlayer.getAllMoves(this);

        // Get all attacked fields for players
        whitePlayer.getAttackedFields(this);
        blackPlayer.getAttackedFields(this);

        if (availableMoves.size() == 0) {
          boolean stalemate = activePlayer.checkIfInCheck();
          this.game.setGameState(stalemate ? GameState.DRAW : (!activePlayer.white ? GameState.WHITE_WIN : GameState.BLACK_WIN));
        }
      }

      selectedActor = null;
      selection = false;
    }
  }
  
  // Draw board, actors and events
  public void draw(int hoveredX, int hoveredY) {
    // Draw tiles
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        drawCheck(i, j);
      }
    }

    // Draw selection
    if (selection) {
      for (int i = 0; i < moves.size(); i++) {
        Move move = moves.get(i);
        if (move.target == null) drawRect(move.x, move.y, 0, 255, 0, 120);
        else drawRect(move.x, move.y, 255, 0, 0, 120);
      }
    }

    // Draw actors
    for (int i = 0; i < whitePlayer.actors.size(); i++) {
      Actor actor = whitePlayer.actors.get(i);
      if (actor.isInDanger(this)) drawRect(actor.posX, actor.posY, 255, 120, 120, 120);
      actor.draw(selectedActor != null && actor.id == selectedActor.id);
    }
    for (int i = 0; i < blackPlayer.actors.size(); i++) {
      Actor actor = blackPlayer.actors.get(i);
      if (actor.isInDanger(this)) drawRect(actor.posX, actor.posY, 255, 120, 120, 120);
      actor.draw(selectedActor != null && actor.id == selectedActor.id);
    }
  }
}
