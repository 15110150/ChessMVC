using System.Collections.Generic;

namespace ChessResult.Web.Models
{
    public class RoleViewModel
    {
        public int ID { get; set; }

        public string RoleName { get; set; }

        public string Description { get; set; }

        public IEnumerable<UserViewModel> Users { get; set; }
    }
}