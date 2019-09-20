using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ChessResult.Web.Models
{
    public class ItemViewModel
    {
        public IEnumerable<FederationViewModel> AllItems { get; set; }

        public IEnumerable<FederationViewModel> SelectedItems { get; set; }
    }
}