class Game {
  public Board board = new Board();

  // Game constructor
  public Game() {
    super();

    // Setting up board
    board.setup(800);

    // Setting up white team
    setupTeam(true);
    
    // Setting up black team
    setupTeam(false);

    // Loading in all actor images
    board.setupActors();
  }
  
  // Setting up board
  void setupTeam (boolean white) {
    // Adding pawns
    for (int col = 0; col < 8; col++) board.addActor(new Pawn(col, white ? 6 : 1, white));
    
    // Adding rooks
    board.addActor(new Rook(0, white ? 7 : 0, white));
    board.addActor(new Rook(7, white ? 7 : 0, white));
    
    // Adding kights
    board.addActor(new Knight(1, white ? 7 : 0, white));
    board.addActor(new Knight(6, white ? 7 : 0, white));
    
    // Adding bishops
    board.addActor(new Bishop(2, white ? 7 : 0, white));
    board.addActor(new Bishop(5, white ? 7 : 0, white));
    
    // Adding king
    board.addActor(new King(3, white ? 7 : 0, white));
    
    // Adding queen
    board.addActor(new Queen(4, white ? 7 : 0, white));
  }

  // Drawing game
  public void draw() {
    int hoveredX = (int)(((float)mouseX / 800.0) * 8);
    int hoveredY = (int)(((float)mouseY / 800.0) * 8);
    board.draw(hoveredX, hoveredY);
  }

  // Forwarding click events
  public void mouseClicked() {
    board.mouseClicked();
  }
}
