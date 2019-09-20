using System.Collections.Generic;
using System.Web.Mvc;
using AutoMapper;
using ChessResult.Model.Model;
using ChessResult.Service.Infrastucture;
using ChessResult.Web.Models;

namespace ChessResult.Web.Controllers
{
    public class HomeController : Controller
    {
        private readonly IFederationService _federationService;

        public HomeController(IFederationService federationService)
        {
            _federationService = federationService;
        }

        public ActionResult Index()
        {
            var federations = _federationService.GetAll();
            ViewBag.Federations = Mapper.Map<IEnumerable<Federation>, IEnumerable<FederationViewModel>>(federations);

            return View();
        }
    }
}