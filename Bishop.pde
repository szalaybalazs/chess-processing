class Bishop extends Actor {
  public Bishop(int x, int y, boolean white) {
    super(x, y, white);
    name = "Bishop";
  }

  // Generate diagonal moves
  public ArrayList<Move> getAvailableMoves(Board board) {
    ArrayList<Move> moves = new ArrayList<Move>();
    
    // Forward Right
    int fr = 0;
    while (posY + direction * fr >= 0 && posY + direction * fr <= 7) {
      fr++;
      Move move = new Move(posX + fr, posY + direction * fr, null);
      Actor targetActor = board.getActor(move.x, move.y);
      if (targetActor == null) moves.add(move);
      else if (isAlly(targetActor)) break;
      else {
        move.target = targetActor;
        moves.add(move);
        break;
      }
    }

    // Backward Right
    int br = 0;
    while (posY - direction * br >= 0 && posY - direction * br <= 7) {
      br++;
      Move move = new Move(posX + br, posY - direction * br, null);
      Actor targetActor = board.getActor(move.x, move.y);
      if (targetActor == null) moves.add(move);
      else if (isAlly(targetActor)) break;
      else {
        move.target = targetActor;
        moves.add(move);
        break;
      }
    }

    // Forward Left
    int fl = 0;
    while (posY + direction * fl >= 0 && posY + direction * fl <= 7) {
      fl++;
      Move move = new Move(posX - fl, posY + direction * fl, null);
      Actor targetActor = board.getActor(move.x, move.y);
      if (targetActor == null) moves.add(move);
      else if (isAlly(targetActor)) break;
      else {
        move.target = targetActor;
        moves.add(move);
        break;
      }
    }

    // Backward Left
    int bl = 0;
    while (posY - direction * bl >= 0 && posY - direction * bl <= 7) {
      bl++;
      Move move = new Move(posX - bl, posY - direction * bl, null);
      Actor targetActor = board.getActor(move.x, move.y);
      if (targetActor == null) moves.add(move);
      else if (isAlly(targetActor)) break;
      else {
        move.target = targetActor;
        moves.add(move);
        break;
      }
    }

    for (int i = 0; i < moves.size(); i++) moves.get(i).source = this;
    
    return moves;
  }
}
