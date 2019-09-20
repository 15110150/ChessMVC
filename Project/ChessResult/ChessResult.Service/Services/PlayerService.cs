using System;
using System.Collections.Generic;
using ChessResult.Model.Model;
using ChessResult.Repository.Infrastructure;
using ChessResult.Service.Infrastucture;

namespace ChessResult.Service.Services
{
    public class PlayerService : IPlayerService
    {
        private readonly IPlayerRepository _playerRepository;

        public PlayerService(IPlayerRepository playerRepository)
        {
            _playerRepository = playerRepository;
        }

        public IEnumerable<Player> GetListPlayerOfFederationInTournament(int tourID, int federationID)
        {
            return _playerRepository.GetListPlayerOfFederationInTournament(tourID, federationID);
        }

        public Player GetPlayerByID(int id)
        {
            return _playerRepository.GetById(id);
        }
    }
}