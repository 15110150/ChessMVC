using System;
using ChessResult.Model.Abstract;

namespace ChessResult.Model.Model
{
    public class Player : Record
    {
        public int PlayerID { get; set; }

        public string Name { get; set; }

        public DateTime BirthDate { get; set; }

        public string Image { get; set; }

        public int FederationID { get; set; }

        public int Rating { get; set; }

        public int FideID { get; set; }

        public string Sex { get; set; }

        public Federation Federation { get; set; }
    }
}