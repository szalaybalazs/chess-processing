enum GameState {
  RUNNING,
  WHITE_WIN, 
  BLACK_WIN,
  DRAW
}

class Game {
  public Board board = new Board();

  GameState gameState = GameState.RUNNING;

  // Game constructor
  public Game() {
    super();

    // Setting up board
    board.setup(800);
    board.setGame(this);

    // Setting opponents
    board.whitePlayer.setOpponent(board.blackPlayer);
    board.blackPlayer.setOpponent(board.whitePlayer);

    // Setting up white team
    setupTeam(board.whitePlayer);
    
    // Setting up black team
    setupTeam(board.blackPlayer);

    // Loading in all actor images
    board.setupActors();
  }
  
  public void setGameState(GameState state) {
    this.gameState = state;
  }

  // Setting up board
  void setupTeam (Player player) {
    boolean white = player.white;
    // Adding pawns
    for (int col = 0; col < 8; col++) player.addActor(new Pawn(col, white ? 6 : 1, white));
    
    // Adding rooks
    player.addActor(new Rook(0, white ? 7 : 0, white));
    player.addActor(new Rook(7, white ? 7 : 0, white));
    
    // Adding kights
    player.addActor(new Knight(1, white ? 7 : 0, white));
    player.addActor(new Knight(6, white ? 7 : 0, white));
    
    // Adding bishops
    player.addActor(new Bishop(2, white ? 7 : 0, white));
    player.addActor(new Bishop(5, white ? 7 : 0, white));
    
    // Adding king
    player.addActor(new King(4, white ? 7 : 0, white));
    
    // Adding queen
    player.addActor(new Queen(3, white ? 7 : 0, white));
  }

  // Drawing game
  public void draw() {
    int hoveredX = (int)(((float)mouseX / 800.0) * 8);
    int hoveredY = (int)(((float)mouseY / 800.0) * 8);
    board.draw(hoveredX, hoveredY);
    if (gameState == GameState.DRAW) drawText("Draw, nobody wins");
    else if (gameState == GameState.WHITE_WIN) drawText("White wins");
    else if (gameState == GameState.BLACK_WIN) drawText("Black wins");
  }

  public void drawText(String text) {
    fill(0, 0, 0, 120);
    rect(0, 0, 800, 800);
    textSize(48);
    fill(255);
    textAlign(CENTER, CENTER);
    text(text, 0, 0, 800, 800);
  }

  // Forwarding click events
  public void mouseClicked() {
    if (gameState == GameState.RUNNING) board.mouseClicked();
    
  }
}
