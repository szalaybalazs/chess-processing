class Board {
  private int dim = 0;
  private int tileDimensions = 0;
  
  ArrayList<Actor> actors = new ArrayList<Actor>();
  public void setup(int dimensions) {
    dim = dimensions;
    tileDimensions = dimensions / 8;
  }
  
  public void addActor(Actor actor) {
    // actors = append(actors, actor);
    actor.setTileDimensions(tileDimensions);
    actors.add(actor);
  }

  private void drawCheck(int x, int y, boolean hovered) {
    int posX = tileDimensions * x;
    int posY = tileDimensions * y;
    boolean isWhite = (x + y) % 2 == 1;

    fill(isWhite ? (hovered ? 200 : 255) : (hovered ? 200 : 120));
    rect(posX, posY, tileDimensions, tileDimensions);
  }
  
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
  
  public void draw(int hoveredX, int hoveredY) {
    Actor hoveredActor = getActor(hoveredX, hoveredY);
    for(int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        drawCheck(i, j, hoveredActor != null && hoveredX == i && hoveredY == j);
      }
    }
    for(int i = 0; i < actors.size(); i++) {
      actors.get(i).draw();
    }
  }
}
