using System.ComponentModel.DataAnnotations;
using System.Web.Security;

namespace ChessResult.Web.Models
{
    public class RegisterViewModel
    {
        private const int MaxLengthPass = 50;
        private const int MinLengthPass = 5;

        [Required]
        [Display(Name = "User Name")]
        public string UserName { get; set; }

        [Required(ErrorMessage = "Password is required.")]
        [DataType(DataType.Password)]
        [StringLength(MaxLengthPass, ErrorMessage = "The {0} must be at least {2} characters long.", MinimumLength = MinLengthPass)]
        [Display(Name = "Password")]
        public string Password { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Confirm password")]
        [Compare("Password", ErrorMessage = "Password and Confirmation Password must match.")]
        [Required(ErrorMessage = "Confirmation Password is required.")]
        public string ConfirmPassword { get; set; }
    }
}