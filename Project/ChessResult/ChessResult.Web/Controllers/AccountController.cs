using System;
using System.Security.Claims;
using System.Web;
using System.Web.Mvc;
using ChessResult.Model.Model;
using ChessResult.Service.Infrastucture;
using ChessResult.Web.Models;
using ChessResult.Web.Utilities;
using Microsoft.AspNet.Identity;

namespace ChessResult.Web.Controllers
{
    public class AccountController : Controller
    {
        private readonly IUserService _userService;
        private readonly ClaimsIdentity _identity;

        public AccountController(IUserService userService)
        {
            _userService = userService;
            _identity = new ClaimsIdentity(DefaultAuthenticationTypes.ApplicationCookie);
        }

        [AllowAnonymous]
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult Login(UserViewModel userVM)
        {
            var user = new User();
            user.ConvertToUser(userVM);

            if (ModelState.IsValid && CheckLogin(user))
            {
                return RedirectToAction("Index", "Home");
            }

            ModelState.AddModelError("", "Invalid login attempt.");
            return View();
        }

        [AllowAnonymous]
        public ActionResult Register()
        {
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult Register(RegisterViewModel registerVM)
        {
            var user = new User();
            user.ConvertToUser(registerVM);

            if (ModelState.IsValid && !ExistUserName(registerVM.UserName))
            {
                _userService.AddUser(user);
                return RedirectToAction("Login", "Account");
            }

            if (ExistUserName(registerVM.UserName))
            {
                ModelState.AddModelError("", "This UserName already exists. Please choose another");
            }

            ModelState.AddModelError("", "Invalid register attempt.");

            return View();
        }

        private bool ExistUserName(string userName)
        {
            var user = _userService.FindUserName(userName);
            return (user != null);
        }

        private bool CheckLogin(User user)
        {
            bool result = false;
            try
            {
                var userInfo = _userService.FindUser(user);
                if (userInfo != null)
                {
                    _identity.AddClaim(new Claim(ClaimTypes.NameIdentifier, userInfo.ID.ToString()));
                    _identity.AddClaim(new Claim(ClaimTypes.Name, userInfo.UserName));
                    _identity.AddClaim(new Claim(ClaimTypes.Role, userInfo.Role.RoleName));

                    HttpContext.GetOwinContext().Authentication.SignIn(_identity);

                    result = true;
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("Error", ex.Message);
            }

            return result;
        }

        public ActionResult Logout()
        {
            HttpContext.GetOwinContext().Authentication.SignOut();

            return RedirectToAction("Index", "Home");
        }
    }
}