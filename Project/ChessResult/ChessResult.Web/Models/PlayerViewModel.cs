using System;

namespace ChessResult.Web.Models
{
    public class PlayerViewModel
    {
        public int PlayerID { get; set; }

        public string Name { get; set; }

        public DateTime BirthDate { get; set; }

        public string Image { get; set; }

        public int FideID { get; set; }

        public int FederationID { get; set; }

        public int Rating { get; set; }

        public string Sex { get; set; }

        public FederationViewModel Federation { get; set; }
    }
}