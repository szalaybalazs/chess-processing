class King extends Actor {
  public King(int x, int y, boolean white) {
    super(x, y, white);
    name = "King";
  }

  private boolean isKingInDanger = false;

  public ArrayList<Move> getAvailableMoves(Board board) {
    ArrayList<Move> moves = new ArrayList<Move>();

    // Creating all possible moves
    {
      Move move = new Move(posX, posY + direction, null);
      Actor targetActor = board.getActor(move.x, move.y);
      move.target = targetActor;
      if (!(isAlly(targetActor) || player.checkIfFieldIsAttacked(move.x, move.y))) moves.add(move);
    }
    {
      Move move = new Move(posX + 1, posY + direction, null);
      Actor targetActor = board.getActor(move.x, move.y);
      move.target = targetActor;
      if (!(isAlly(targetActor) || player.checkIfFieldIsAttacked(move.x, move.y))) moves.add(move);
    }
    {
      Move move = new Move(posX - 1, posY + direction, null);
      Actor targetActor = board.getActor(move.x, move.y);
      move.target = targetActor;
      if (!(isAlly(targetActor) || player.checkIfFieldIsAttacked(move.x, move.y))) moves.add(move);
    }
    
    {
      Move move = new Move(posX, posY - direction, null);
      Actor targetActor = board.getActor(move.x, move.y);
      move.target = targetActor;
      if (!(isAlly(targetActor) || player.checkIfFieldIsAttacked(move.x, move.y))) moves.add(move);
    }
    {
      Move move = new Move(posX + 1, posY - direction, null);
      Actor targetActor = board.getActor(move.x, move.y);
      move.target = targetActor;
      if (!(isAlly(targetActor) || player.checkIfFieldIsAttacked(move.x, move.y))) moves.add(move);
    }
    {
      Move move = new Move(posX - 1, posY - direction, null);
      Actor targetActor = board.getActor(move.x, move.y);
      move.target = targetActor;
      if (!(isAlly(targetActor) || player.checkIfFieldIsAttacked(move.x, move.y))) moves.add(move);
    }
    {
      Move move = new Move(posX + 1, posY, null);
      Actor targetActor = board.getActor(move.x, move.y);
      move.target = targetActor;
      if (!(isAlly(targetActor) || player.checkIfFieldIsAttacked(move.x, move.y))) moves.add(move);
    }
    {
      Move move = new Move(posX - 1, posY, null);
      Actor targetActor = board.getActor(move.x, move.y);
      move.target = targetActor;
      if (!(isAlly(targetActor) || player.checkIfFieldIsAttacked(move.x, move.y))) moves.add(move);
    }

    for (int i = 0; i < moves.size(); i++) moves.get(i).source = this;

    return moves;
  }

  // Checking is king is in check
  public void checkForDanger(Board board) {
    ArrayList<Actor> actors = this.opponent.getActors();
    isKingInDanger = false;
    
    for (int i = 0; i < actors.size(); i++) {
      Actor actor = actors.get(i);
      ArrayList<Move> moves = actor.getAvailableMoves(board);
      for (int j = 0; j < moves.size(); j++) {
        Move move = moves.get(j);
        if (move.target == this) isKingInDanger = true;
      }
    }
  }

  // Returning predefined danger
  public boolean isInDanger(Board board) {
    return player.checkIfInCheck();
  }
}
