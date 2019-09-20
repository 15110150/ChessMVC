using System.Collections.Generic;

namespace ChessResult.Model.Model
{
    public class Round
    {
        public int ID { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }

        public IEnumerable<Pairing> Pairings { get; set; }
    }
}