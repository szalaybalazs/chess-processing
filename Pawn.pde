class Pawn extends Actor {
  public Pawn(int x, int y, boolean white) {
    super(x, y, white);
    name = "Pawn";
  }

  public Actor moveTo(Move move) {
    previousMoves.add(move);
    previousMove = currentMove;
    currentMove++;
    setPosition(move.x, move.y);
    numberOfMoves++;

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

    // en passant left
    {
      Actor target = opponent.getActor(posX - 1, posY);
      Actor moveActor = board.getActor(posX - 1, posY + direction);
      // println("en passant, target: ", target != null, " free tile: ", moveActor == null, " target position: ", target != null ? target.posY : -1);
      if (target != null && target.name == "Pawn" && target.numberOfMoves == 1 && (target.posY == 3 || target.posY == 4) && moveActor == null) moves.add(new Move(posX - 1, posY + direction, target));
    }
    // en passant right
    {
      Actor target = opponent.getActor(posX + 1, posY);
      Actor moveActor = board.getActor(posX + 1, posY + direction);
      // println("en passant, target: ", target != null, " free tile: ", moveActor == null, " target position: ", target != null ? target.posY : -1);
      if (target != null && target.name == "Pawn" && target.numberOfMoves == 1 && (target.posY == 3 || target.posY == 4) && moveActor == null) moves.add(new Move(posX + 1, posY + direction, target));
    }

    for (int i = 0; i < moves.size(); i++) moves.get(i).source = this;

    return moves;
  }
}
