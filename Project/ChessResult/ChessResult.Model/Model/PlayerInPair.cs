using System;
using ChessResult.Model.Abstract;

namespace ChessResult.Model.Model
{
    public class PlayerInPair : Record
    {
        public int PairingID { get; set; }

        public int PlayerID { get; set; }

        public bool IsWhite { get; set; }

        public float Mark { get; set; }

        public Pairing Pairing { get; set; }

        public Player Player { get; set; }
    }
}