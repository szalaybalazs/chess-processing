class Board {
  private int dim = 0;
  private int tileDimensions = 0;

  private boolean selection = false;
  private int activeX = 0;
  private int activeY = 0;

  Actor selectedActor;


  ArrayList<Move> moves = new ArrayList<Move>();
  ArrayList<Actor> actors = new ArrayList<Actor>();

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

  public void mouseClicked() {
    int x = (int)(((float)mouseX / 800.0) * 8);
    int y = (int)(((float)mouseY / 800.0) * 8);

    Actor actor = getActor(x, y);
    if (actor != null && !selection) {
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
          // TODO: save takes
        }
      }
      selectedActor = null;
      selection = false;
    }
  }
  
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
      actor.draw(selectedActor != null && actor.id == selectedActor.id);
    }
  }
}
