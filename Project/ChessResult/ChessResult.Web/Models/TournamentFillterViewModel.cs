using System;
using System.ComponentModel.DataAnnotations;

namespace ChessResult.Web.Models
{
    public class TournamentFillterViewModel
    {
        public string Name { get; set; }

        [Display(Name = "Federation")]
        public int? FederationID { get; set; }

        [Display(Name = "From Date")]
        public DateTime? StartDate { get; set; }
    }
}