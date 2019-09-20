using System;
using System.ComponentModel.DataAnnotations;

namespace ChessResult.Web.Models
{
    public class UserViewModel
    {
        public int ID { get; set; }

        [Required]
        public string UserName { get; set; }

        [Required]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        public int RoleID { get; set; }

        public RoleViewModel Role { get; set; }

        public DateTime? CreatedDate { get; set; }

        public DateTime? UpdatedDate { get; set; }

        public bool Status { get; set; }
    }
}