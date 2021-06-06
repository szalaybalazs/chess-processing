class Pawn extends Actor {
  public Pawn(int x, int y, boolean white) {
    super(x, y, white);
    imageName = "Pawn";
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
    return moves;
  }
}
