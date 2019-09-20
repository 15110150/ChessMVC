using System;
using System.Collections.Generic;
using ChessResult.Model.Model;
using ChessResult.Repository.Infrastructure;
using ChessResult.Service.Infrastucture;

namespace ChessResult.Service.Services
{
    public class RoundService : IRoundService
    {
        private readonly IRoundRepository _roundRepository;
        private readonly IPairingRepository _pairingRepository;
        private readonly IPlayerInPairRepository _playerInPairRepository;

        public RoundService(IRoundRepository roundRepository, IPairingRepository pairingRepository, IPlayerInPairRepository playerInPairRepository)
        {
            _roundRepository = roundRepository;
            _pairingRepository = pairingRepository;
            _playerInPairRepository = playerInPairRepository;
        }

        public IEnumerable<Round> GetAllRoundPairingInTournament(int id)
        {
            var rounds = _roundRepository.GetListRoundByTournament(id);
            foreach (var round in rounds)
            {
                round.Pairings = _pairingRepository.GetListPairingInTourRound(round.ID, id);
                foreach (var pair in round.Pairings)
                {
                    pair.PlayerInPairs = _playerInPairRepository.GetListPlayerInParing(pair.PairingID);
                }
            }

            return rounds;
        }

        public IEnumerable<Round> GetListRoundByTournament(int id)
        {
            return _roundRepository.GetListRoundByTournament(id);
        }
    }
}