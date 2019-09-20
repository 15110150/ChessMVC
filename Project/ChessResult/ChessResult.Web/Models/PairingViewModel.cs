using System;
using System.Collections.Generic;

namespace ChessResult.Web.Models
{
    public class PairingViewModel
    {
        public int PairingID { get; set; }

        public int RoundID { get; set; }

        public int TournamentID { get; set; }

        public DateTime StartTime { get; set; }

        public DateTime EndTime { get; set; }

        public DateTime? CreatedDate { get; set; }

        public string CreatedBy { get; set; }

        public DateTime? UpdatedDate { get; set; }

        public RoundViewModel Round { get; set; }

        public TournamentViewModel Tournament { get; set; }

        public IEnumerable<PlayerInPairViewModel> PlayerInPairs { get; set; }
    }
}