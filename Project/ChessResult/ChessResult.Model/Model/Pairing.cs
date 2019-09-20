using System;
using System.Collections.Generic;
using ChessResult.Model.Abstract;

namespace ChessResult.Model.Model
{
    public class Pairing : Record
    {
        public int PairingID { get; set; }

        public int RoundID { get; set; }

        public DateTime StartTime { get; set; }

        public DateTime EndTime { get; set; }

        public int TournamentID { get; set; }

        public Round Round { get; set; }

        public Tournament Tournament { get; set; }

        public IEnumerable<PlayerInPair> PlayerInPairs { get; set; }
    }
}