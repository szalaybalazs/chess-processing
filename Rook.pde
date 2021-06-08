class Rook extends Actor {
  public Rook(int x, int y, boolean white) {
    super(x, y, white);
    name = "Rook";
  }

  // Creating all vertical and horizontal moves
  public ArrayList<Move> getAvailableMoves(Board board) {
    ArrayList<Move> moves = new ArrayList<Move>();
    
    // Forward
    int f = 0;
    while (posY + direction * f >= 0 && posY + direction * f <= 7) {
      f++;
      Move move = new Move(posX, posY + direction * f, null);
      Actor targetActor = board.getActor(move.x, move.y);
      if (targetActor == null) moves.add(move);
      else if (isAlly(targetActor)) break;
      else {
        move.target = targetActor;
        moves.add(move);
        break;
      }
    }

    // Backward
    int b = 0;
    while (posY - direction * b >= 0 && posY - direction * b <= 7) {
      b++;
      Move move = new Move(posX, posY - direction * b, null);
      Actor targetActor = board.getActor(move.x, move.y);
      if (targetActor == null) moves.add(move);
      else if (isAlly(targetActor)) break;
      else {
        move.target = targetActor;
        moves.add(move);
        break;
      }
    }

    // Left
    int l = 0;
    while (posX - l >= 0) {
      l++;
      Move move = new Move(posX - l, posY, null);
      Actor targetActor = board.getActor(move.x, move.y);
      if (targetActor == null) moves.add(move);
      else if (isAlly(targetActor)) break;
      else {
        move.target = targetActor;
        moves.add(move);
        break;
      }
    }

    // Right
    int r = 0;
    while (posX + r <= 7) {
      r++;
      Move move = new Move(posX + r, posY, null);
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
