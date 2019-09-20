using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace ChessResult.Web.Models
{
    public class TournamentViewModel
    {
        public int ID { get; set; }

        [Required]
        [Display(Name = "Tournament Name")]
        public string Name { get; set; }

        public int FederationID { get; set; }

        public int FormID { get; set; }

        [Required]
        public DateTime StartDate { get; set; }

        [Required]
        public DateTime EndDate { get; set; }

        public string Description { get; set; }

        public string Organizer { get; set; }

        public string Director { get; set; }

        public string Location { get; set; }

        [Display(Name = "Parent tournament")]
        public int? ParentTourID { get; set; }

        public IEnumerable<FederationViewModel> FederationPaticipate { get; set; }

        public IEnumerable<RoundViewModel> Rounds { get; set; }

        public IEnumerable<StatisticPlayerViewModel> StatisticPlayer { get; set; }

        public IEnumerable<TournamentViewModel> ChildenTournament { get; set; }

        public FederationViewModel Federation { get; set; }

        public FormViewModel Form { get; set; }

        public DateTime? CreatedDate { get; set; }

        public string CreatedBy { get; set; }

        public DateTime? UpdatedDate { get; set; }

        public string UpdatedBy { get; set; }

        public bool Status { get; set; }
    }
}