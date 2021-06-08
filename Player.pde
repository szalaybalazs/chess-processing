class Player {
  ArrayList<Actor> actors = new ArrayList<Actor>();
  boolean white;
  Player opponent;
  int tileDimensions = 0;

  ArrayList<Move> attacks = new ArrayList<Move>();
  
  public Player(boolean white) {
    this.white = white;
  }

  public void setOpponent(Player player) {
    this.opponent = player;
  }

  public void setTileDimensions(int dimensions) {
    tileDimensions = dimensions;
  }

  // Add actor to board
  public void addActor(Actor actor) {
    actor.setColor(white);
    actor.setPlayer(this, opponent);
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

  // Move actor
  public void moveActor(Actor actor, Move move) {
    int index = actors.indexOf(actor);
    Actor newActor = actor.moveTo(move);
    if (newActor != actor) actors.set(index, newActor);
  }

  // Remove actor
  public void removeActor(Actor actor) {
    int index = actors.indexOf(actor);
    actors.remove(index);
  }

  // Get all actors of a player
  public ArrayList<Actor> getActors() {
    return actors;
  }

  // Setup all actors
  public void setupActors() {
    for (int i = 0; i < actors.size(); i++) {
      actors.get(i).setup();
    }
  }

  public boolean checkIfFieldIsAttacked(int x, int y, ArrayList<Move> attacks) {
    for (int i = 0; i < attacks.size(); i++) {
      Move move = attacks.get(i);
      if (move.x == x && move.y == y) return true;
    }
    return false;
  }
  public boolean checkIfFieldIsAttacked(int x, int y) {
    return checkIfFieldIsAttacked(x, y, attacks);
  }

  public ArrayList<Move> generateAttackedfields(Board board) {
    ArrayList<Move> moves = new ArrayList<Move>();
    for(int i = 0; i < this.opponent.getActors().size(); i++) {
      Actor actor = this.opponent.getActors().get(i);
      if (actor.name != "King") moves.addAll(actor.getAvailableMoves(board));
    }

    return moves;
  }

  public ArrayList<Move> getAllMoves(Board board) {
    ArrayList<Move> moves = new ArrayList<Move>();
    for(int i = 0; i < getActors().size(); i++) {
      Actor actor = getActors().get(i);
      moves.addAll(actor.getAllMoves(board));
    }

    return moves;
  }

  public ArrayList<Move> getAttackedFields(Board board) {
    ArrayList<Move> moves = generateAttackedfields(board);
    attacks = moves;
    return moves;
  }

  public Actor getKing() {
    Actor actor = null;
    int i = 0;
    while(i < actors.size() && actor == null) {
      if (actors.get(i).name == "King") actor = actors.get(i);
      i++;
    }

    return actor;
  }

  public boolean checkIfInCheck(){
    Actor king = getKing();
    boolean isAttacked = checkIfFieldIsAttacked(king.posX, king.posY, attacks);

    return isAttacked;
  }

  public boolean checkSolution(ArrayList<Move> moves){
    Actor king = getKing();
    boolean isAttacked = checkIfFieldIsAttacked(king.posX, king.posY, moves);

    return isAttacked;
  }
}