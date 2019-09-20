using System;

namespace ChessResult.Model.DTO
{
    public class TournamentFilter
    {
        public string Name { get; set; }

        public int? FederationID { get; set; }

        public DateTime? StartDate { get; set; }
    }
}