class Pawn extends Actor {
  public Pawn(int x, int y, boolean white) {
    super(x, y, white);
    name = "Pawn";
  }

  public Actor moveTo(Move move) {
    previousMoves.add(move);
    setPosition(move.x, move.y);

    if (move.y == 0 || move.y == 7) {
      Actor queen = new Queen(move.x, move.y, white);
      queen.setup();
      queen.setTileDimensions(tileDimensions);
      return queen;
    } 
    else return this;
  }

  public ArrayList<Move> getAvailableMoves(Board board) {
    ArrayList<Move> moves = new ArrayList<Move>();
    Actor frontActor = board.getActor(posX, posY + direction);
    Actor doubleFrontActor = board.getActor(posX, posY + direction * 2);
    Actor frontLeft = board.getActor(posX - 1, posY + direction);
    Actor frontRight = board.getActor(posX + 1, posY + direction);
    
    // Checking if forward space is free
    if (frontActor == null) moves.add(new Move(posX, posY + direction, null));
    
    // Checking first move for pawns
    if (doubleFrontActor == null && previousMoves.size() == 0) moves.add(new Move(posX, posY + direction * 2, null));
    
    // Checking take opportunities
    if (frontLeft != null && !isAlly(frontLeft)) moves.add(new Move(frontLeft.posX, frontLeft.posY, frontLeft));
    if (frontRight != null && !isAlly(frontRight)) moves.add(new Move(frontRight.posX, frontRight.posY, frontRight));

    // TODO: special pawn moves
    for (int i = 0; i < moves.size(); i++) moves.get(i).source = this;

    return moves;
  }
}
