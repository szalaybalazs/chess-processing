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
      if (!isAlly(targetActor) && (targetActor == null || targetActor.name != "King")) moves.add(move);
      else if (move.target == null && !player.checkIfFieldIsAttacked(move.x, move.y)) moves.add(move);
    }
    {
      Move move = new Move(posX + 1, posY + direction, null);
      Actor targetActor = board.getActor(move.x, move.y);
      move.target = targetActor;
      if (!isAlly(targetActor) && (targetActor == null || targetActor.name != "King")) moves.add(move);
      else if (move.target == null && !player.checkIfFieldIsAttacked(move.x, move.y)) moves.add(move);
    }
    {
      Move move = new Move(posX - 1, posY + direction, null);
      Actor targetActor = board.getActor(move.x, move.y);
      move.target = targetActor;
      if (!isAlly(targetActor) && (targetActor == null || targetActor.name != "King")) moves.add(move);
      else if (move.target == null && !player.checkIfFieldIsAttacked(move.x, move.y)) moves.add(move);
    }
    
    {
      Move move = new Move(posX, posY - direction, null);
      Actor targetActor = board.getActor(move.x, move.y);
      move.target = targetActor;
      if (!isAlly(targetActor) && (targetActor == null || targetActor.name != "King")) moves.add(move);
      else if (move.target == null && !player.checkIfFieldIsAttacked(move.x, move.y)) moves.add(move);
    }
    {
      Move move = new Move(posX + 1, posY - direction, null);
      Actor targetActor = board.getActor(move.x, move.y);
      move.target = targetActor;
      if (!isAlly(targetActor) && (targetActor == null || targetActor.name != "King")) moves.add(move);
      else if (move.target == null && !player.checkIfFieldIsAttacked(move.x, move.y)) moves.add(move);
    }
    {
      Move move = new Move(posX - 1, posY - direction, null);
      Actor targetActor = board.getActor(move.x, move.y);
      move.target = targetActor;
      if (!isAlly(targetActor) && (targetActor == null || targetActor.name != "King")) moves.add(move);
      else if (move.target == null && !player.checkIfFieldIsAttacked(move.x, move.y)) moves.add(move);
    }
    {
      Move move = new Move(posX + 1, posY, null);
      Actor targetActor = board.getActor(move.x, move.y);
      move.target = targetActor;
      if (!isAlly(targetActor) && (targetActor == null || targetActor.name != "King")) moves.add(move);
      else if (move.target == null && !player.checkIfFieldIsAttacked(move.x, move.y)) moves.add(move);
    }
    {
      Move move = new Move(posX - 1, posY, null);
      Actor targetActor = board.getActor(move.x, move.y);
      move.target = targetActor;
      if (!isAlly(targetActor) && (targetActor == null || targetActor.name != "King")) moves.add(move);
      else if (move.target == null && !player.checkIfFieldIsAttacked(move.x, move.y)) moves.add(move);
    }

    // Castling right
    {
      if (player.getActor(5, posY) == null && player.getActor(6, posY) == null) {
        Actor rook = player.getActor(7, posY);
        if (numberOfMoves == 0 && rook.numberOfMoves == 0) {
          Move move = new Move(6, posY, null);
          move.effect = new Move(5, posY, null);
          move.effect.source = rook;
          moves.add(move);
        }
      }
    }
    // Castling left
    {
      if (player.getActor(1, posY) == null && player.getActor(2, posY) == null && player.getActor(2, posY) == null) {
        Actor rook = player.getActor(0, posY);
        if (numberOfMoves == 0 && rook.numberOfMoves == 0) {
          Move move = new Move(2, posY, null);
          move.effect = new Move(3, posY, null);
          move.effect.source = rook;
          moves.add(move);
        }
      }
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
