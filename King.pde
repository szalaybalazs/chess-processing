class King extends Actor {
  public King(int x, int y, boolean white) {
    super(x, y, white);
    imageName = "King";
  }

  public ArrayList<Move> getAvailableMoves(Board board) {
    ArrayList<Move> moves = new ArrayList<Move>();
    
    // TODO: check if field is attacked
    {
      Move move = new Move(posX, posY + direction, null);
      Actor targetActor = board.getActor(move.x, move.y);
      move.target = targetActor;
      if (!isAlly(targetActor)) moves.add(move);
    }
    {
      Move move = new Move(posX + 1, posY + direction, null);
      Actor targetActor = board.getActor(move.x, move.y);
      move.target = targetActor;
      if (!isAlly(targetActor)) moves.add(move);
    }
    {
      Move move = new Move(posX - 1, posY + direction, null);
      Actor targetActor = board.getActor(move.x, move.y);
      move.target = targetActor;
      if (!isAlly(targetActor)) moves.add(move);
    }
    
    {
      Move move = new Move(posX, posY - direction, null);
      Actor targetActor = board.getActor(move.x, move.y);
      move.target = targetActor;
      if (!isAlly(targetActor)) moves.add(move);
    }
    {
      Move move = new Move(posX + 1, posY - direction, null);
      Actor targetActor = board.getActor(move.x, move.y);
      move.target = targetActor;
      if (!isAlly(targetActor)) moves.add(move);
    }
    {
      Move move = new Move(posX - 1, posY - direction, null);
      Actor targetActor = board.getActor(move.x, move.y);
      move.target = targetActor;
      if (!isAlly(targetActor)) moves.add(move);
    }
    {
      Move move = new Move(posX + 1, posY, null);
      Actor targetActor = board.getActor(move.x, move.y);
      move.target = targetActor;
      if (!isAlly(targetActor)) moves.add(move);
    }
    {
      Move move = new Move(posX - 1, posY, null);
      Actor targetActor = board.getActor(move.x, move.y);
      move.target = targetActor;
      if (!isAlly(targetActor)) moves.add(move);
    }

    return moves;
  }
}
