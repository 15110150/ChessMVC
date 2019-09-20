using System.Collections.Generic;

namespace ChessResult.Web.Models
{
    public class RoundViewModel
    {
        public int ID { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }

        public IEnumerable<PairingViewModel> Pairings { get; set; }
    }
}