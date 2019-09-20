using System.Collections.Generic;
using ChessResult.Model.Abstract;

namespace ChessResult.Model.Model
{
    public class Role : Record
    {
        public int ID { get; set; }

        public string RoleName { get; set; }

        public string Description { get; set; }

        public IEnumerable<User> Users { get; set; }
    }
}