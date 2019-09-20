using System.Collections.Generic;
using System.Web.Mvc;
using AutoMapper;
using ChessResult.Model.DTO;
using ChessResult.Model.Model;
using ChessResult.Service.Infrastucture;
using ChessResult.Web.Models;
using ChessResult.Web.Utilities;

namespace ChessResult.Web.Controllers
{
    public class TournamentController : Controller
    {
        private readonly ITournamentService _tournamentService;
        private readonly IRoundService _roundService;

        public TournamentController(ITournamentService tournamentService, IFederationService federationService, IRoundService roundService)
        {
            _tournamentService = tournamentService;
            _roundService = roundService;

            var federations = federationService.GetAll();
            ViewBag.Federations = Mapper.Map<IEnumerable<Federation>, IEnumerable<FederationViewModel>>(federations);
        }

        public ActionResult TournamentDetail(int id)
        {
            var result = _tournamentService.GetByID(id);
            var tournament = Mapper.Map<Tournament, TournamentViewModel>(result);

            return View(tournament);
        }

        [Authorize(Roles = "admin")]
        public ActionResult TournamentManager()
        {
            var result = _tournamentService.GetAll();
            var tournaments = Mapper.Map<IEnumerable<Tournament>, IEnumerable<TournamentViewModel>>(result);

            return View(tournaments);
        }

        [HttpGet]
        public ActionResult FilterTournament(TournamentFillterViewModel tournamentFilterVM)
        {
            var filter = new TournamentFilter();
            filter.ConvertToTournametFilter(tournamentFilterVM);

            var result = _tournamentService.FindTournament(filter);
            var tournaments = Mapper.Map<IEnumerable<Tournament>, IEnumerable<TournamentViewModel>>(result);

            return PartialView(tournaments);
        }

        [Authorize(Roles = "admin")]
        public ActionResult AddTournament()
        {
            var tournamentNotHaveChild = _tournamentService.GetTournamentNotHaveChild();
            ViewBag.Tournaments = tournamentNotHaveChild;

            return View();
        }

        [Authorize(Roles = "admin")]
        [HttpPost]
        public ActionResult AddTournament(TournamentViewModel tournamentVM)
        {
            if (ModelState.IsValid)
            {
                var tournament = new Tournament();
                tournament.ConvertToTournament(tournamentVM);

                _tournamentService.AddTournament(tournament);

                return RedirectToAction("TournamentManager", "Tournament");
            }

            return View(tournamentVM);
        }

        [Authorize(Roles = "admin")]
        public ActionResult DeleteTournament(int id)
        {
            _tournamentService.DeleteTournament(id);

            return RedirectToAction("TournamentManager", "Tournament");
        }

        [Authorize(Roles = "admin")]
        public ActionResult UpdateTournament(int id)
        {
            var result = _tournamentService.GetByID(id);
            var tournament = Mapper.Map<Tournament, TournamentViewModel>(result);

            return View(tournament);
        }

        [Authorize(Roles = "admin")]
        [HttpPost]
        public ActionResult UpdateTournament(TournamentViewModel tournamentVM)
        {
            if (ModelState.IsValid)
            {
                var tournament = new Tournament();
                tournament.ConvertToTournament(tournamentVM);

                _tournamentService.UpdateTournament(tournament);

                return RedirectToAction("TournamentManager", "Tournament");
            }

            return View(tournamentVM);
        }

        public ActionResult GetAllRoundInTournament(int id)
        {
            var result = _roundService.GetAllRoundPairingInTournament(id);
            var rounds = Mapper.Map<IEnumerable<Round>, IEnumerable<RoundViewModel>>(result);

            return PartialView(rounds);
        }

        public ActionResult StatictisPlayerInTour(int id)
        {
            var result = _tournamentService.GetByID(id);
            var tournament = Mapper.Map<Tournament, TournamentViewModel>(result);

            return PartialView(tournament);
        }

        public ActionResult GetListFederationParticipate(int id)
        {
            var result = _tournamentService.GetByID(id);
            var tournament = Mapper.Map<Tournament, TournamentViewModel>(result);

            return PartialView(tournament);
        }
    }
}