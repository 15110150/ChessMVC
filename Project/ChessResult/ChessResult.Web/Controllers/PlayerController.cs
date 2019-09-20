using System.Collections.Generic;
using System.Web.Mvc;
using AutoMapper;
using ChessResult.Model.Model;
using ChessResult.Service.Infrastucture;
using ChessResult.Web.Models;

namespace ChessResult.Web.Controllers
{
    public class PlayerController : Controller
    {
        private readonly IPlayerService _playerService;

        public PlayerController(IPlayerService playerService)
        {
            _playerService = playerService;
        }

        public ActionResult GetPlayerByID(int id)
        {
            var result = _playerService.GetPlayerByID(id);
            var players = Mapper.Map<Player, PlayerViewModel>(result);

            return PartialView(players);
        }

        public ActionResult GetListPlayerInTournamentByFederation(int tourID, int federationID)
        {
            var result = _playerService.GetListPlayerOfFederationInTournament(tourID, federationID);
            var players = Mapper.Map<IEnumerable<Player>, IEnumerable<PlayerViewModel>>(result);

            return PartialView(players);
        }
    }
}