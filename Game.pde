class Game {
  public Board board = new Board();
  public Game() {
    super();
    board.setup(800);
    setupTeam(true);
    setupTeam(false);
  }
  
  // Setting up board
  void setupTeam (boolean white) {
    for (int col = 0; col < 8; col++) board.addActor(new Actor(col, white ? 6 : 1, white));
    
    board.addActor(new Rook(0, white ? 7 : 0, white));
    board.addActor(new Rook(7, white ? 7 : 0, white));
    board.addActor(new Knight(1, white ? 7 : 0, white));
    board.addActor(new Knight(6, white ? 7 : 0, white));
    board.addActor(new Bishop(2, white ? 7 : 0, white));
    board.addActor(new Bishop(5, white ? 7 : 0, white));
    board.addActor(new King(3, white ? 7 : 0, white));
    board.addActor(new Queen(4, white ? 7 : 0, white));
  }

  public void draw() {
    int hoveredX = (int)(((float)mouseX / 800.0) * 8);
    int hoveredY = (int)(((float)mouseY / 800.0) * 8);
    board.draw(hoveredX, hoveredY);
  }
}
