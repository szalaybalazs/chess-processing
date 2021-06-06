class Board {
  // Dimensions
  private int dim = 0;
  private int tileDimensions = 0;

  // Store selected actor and selection state
  private boolean selection = false;
  Actor selectedActor;
  
  // Store current player
  private boolean currentPlayerIsWhite = true;

  // Available moves
  ArrayList<Move> moves = new ArrayList<Move>();

  // Store all actors
  ArrayList<Actor> actors = new ArrayList<Actor>();

  // Setup board
  public void setup(int dimensions) {
    dim = dimensions;
    tileDimensions = dimensions / 8;
  }
  
  // Add actor to board
  public void addActor(Actor actor) {
    actor.setTileDimensions(tileDimensions);
    actors.add(actor);
  }

  // Get actor on board
  public Actor getActor(int posX, int posY) {
    Actor actor = null;
    int i = 0;
    while(actor == null && i < actors.size()) {
      Actor _actor = actors.get(i);
      if (_actor.posX == posX && _actor.posY == posY) actor = _actor;
      i++;
    }
    return actor;
  }

  // Get all actors of a player
  public ArrayList<Actor> getActors(boolean white) {
    ArrayList<Actor> playerActors = new ArrayList<Actor>();
    for (int i = 0; i < actors.size(); i++) {
      Actor actor = actors.get(i);
      if (actor.white == white) playerActors.add(actor);
    }

    return playerActors;
  }

  // Setup all actors
  public void setupActors() {
    for (int i = 0; i < actors.size(); i++) {
      actors.get(i).setup();
    }
  }

  // Draw hoverable rect
  private void drawCheck(int x, int y) {
    boolean isWhite = (x + y) % 2 == 1;

    int col = (isWhite ? 255 : 120);
    drawRect(x, y, col, col, col);
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
    if (actor != null && !selection && actor.white == currentPlayerIsWhite) {
      selectedActor = actor;
      moves = actor.getAvailableMoves(this);
      selection = true;
    } else if (selection && selectedActor != null) {
      Move move = null;
      int i = 0;
      while(move == null && i < moves.size()) {
        Move _move = moves.get(i);
        if (_move.x == x && _move.y == y) move = _move;
        i++;
      }

      if (move != null) {
        selectedActor.moveTo(move);
        currentPlayerIsWhite = !currentPlayerIsWhite;
        if (move.target != null) {
          int targetIndex = 0;
          Actor targetActor = null;
          while (targetActor == null && targetIndex < actors.size()) {
            Actor _actor = actors.get(targetIndex);
            if (
              _actor.posX == move.target.posX && 
              _actor.posY == move.target.posY &&
              !_actor.isAlly(selectedActor)
            ) {
              targetActor = _actor;
            } else targetIndex++;
          }

          actors.remove(targetIndex);
        }
        for(int k = 0; k < actors.size(); k++) {
          Actor dangerActor = actors.get(k);
          dangerActor.checkForDanger(this);
        }
      }
      selectedActor = null;
      selection = false;
    }
  }
  
  // Draw board, actors and events
  public void draw(int hoveredX, int hoveredY) {
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        drawCheck(i, j);
      }
    }
    if (selection) {
      for (int i = 0; i < moves.size(); i++) {
        Move move = moves.get(i);
        if (move.target == null) drawRect(move.x, move.y, 0, 255, 0, 120);
        else drawRect(move.x, move.y, 255, 0, 0, 120);
      }
    }
    for (int i = 0; i < actors.size(); i++) {
      Actor actor = actors.get(i);
      if (actor.isInDanger(this)) drawRect(actor.posX, actor.posY, 255, 120, 120, 120);
      actor.draw(selectedActor != null && actor.id == selectedActor.id);
    }
  }
}
