class Knight extends Actor {
  public Knight(int x, int y, boolean white) {
    super(x, y, white);
    name = "Knight";
  }

  public ArrayList<Move> getAvailableMoves(Board board) {
    ArrayList<Move> moves = new ArrayList<Move>();
    
    // Collecting targetable actors
    Actor frontRight = board.getActor(posX + 1, posY + direction * 2);
    Actor frontLeft = board.getActor(posX - 1, posY + direction * 2);
    Actor backRight = board.getActor(posX + 1, posY - direction * 2);
    Actor backLeft = board.getActor(posX - 1, posY - direction * 2);
    
    Actor rightFront = board.getActor(posX + 2, posY + direction);
    Actor rightBack = board.getActor(posX + 2, posY - direction);
    Actor leftFront = board.getActor(posX - 2, posY + direction);
    Actor leftBack = board.getActor(posX - 2, posY - direction);

    // Adding valid moves
    if (!isAlly(frontRight)) moves.add(new Move(posX + 1, posY + direction * 2, frontRight));
    if (!isAlly(frontLeft)) moves.add(new Move(posX - 1, posY + direction * 2, frontLeft));
    if (!isAlly(backRight)) moves.add(new Move(posX + 1, posY - direction * 2, backRight));
    if (!isAlly(backLeft)) moves.add(new Move(posX - 1, posY - direction * 2, backLeft));
    if (!isAlly(rightFront)) moves.add(new Move(posX + 2, posY + direction, rightFront));
    if (!isAlly(rightBack)) moves.add(new Move(posX + 2, posY - direction, rightBack));
    if (!isAlly(leftFront)) moves.add(new Move(posX - 2, posY + direction, leftFront));
    if (!isAlly(leftBack)) moves.add(new Move(posX - 2, posY - direction, leftBack));

    for (int i = 0; i < moves.size(); i++) moves.get(i).source = this;

    return moves;
  }
}
