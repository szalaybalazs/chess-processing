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
  
  public void draw() {
    fill(255, 200, 200);
    for(int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        fill((i + j) % 2 == 1 ? 255 : 120);
        rect(tileDimensions * i, tileDimensions * j, tileDimensions, tileDimensions);
      }
    }
    for(int i = 0; i < actors.size(); i++) {
      actors.get(i).draw();
    }
  }
}
