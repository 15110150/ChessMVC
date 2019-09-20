using System;
using System.Collections.Generic;
using ChessResult.Model.Abstract;
using ChessResult.Model.DTO;

namespace ChessResult.Model.Model
{
    public class Tournament : Record
    {
        public int ID { get; set; }

        public string Name { get; set; }

        public int FederationID { get; set; }

        public int FormID { get; set; }

        public DateTime StartDate { get; set; }

        public DateTime EndDate { get; set; }

        public string Description { get; set; }

        public string Organizer { get; set; }

        public string Director { get; set; }

        public string Location { get; set; }

        public int? ParentTourID { get; set; }

        public IEnumerable<Federation> FederationPaticipate { get; set; }

        public IEnumerable<Round> Rounds { get; set; }

        public IEnumerable<StatisticPlayer> StatisticPlayer { get; set; }

        public IEnumerable<Tournament> ChildenTournament { get; set; }

        public Federation Federation { get; set; }

        public Form Form { get; set; }
    }
}