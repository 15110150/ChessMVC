using System;
using System.Collections.Generic;
using ChessResult.Model.Model;
using ChessResult.Repository.Infrastructure;
using ChessResult.Service.Infrastucture;

namespace ChessResult.Service.Services
{
    public class PairingService : IPairingService
    {
        private readonly IPairingRepository _pairingRepository;
        private readonly IPlayerInPairRepository _playerInPairRepository;

        public PairingService(IPairingRepository pairingRepository, IPlayerInPairRepository playerInPairRepository)
        {
            _pairingRepository = pairingRepository;
            _playerInPairRepository = playerInPairRepository;
        }

        public IEnumerable<Pairing> GetListPairingInTourRound(int roundID, int tourID)
        {
            var pairings = _pairingRepository.GetListPairingInTourRound(roundID, tourID);
            foreach (var pair in pairings)
            {
                pair.PlayerInPairs = _playerInPairRepository.GetListPlayerInParing(pair.PairingID);
            }

            return pairings;
        }

        public IEnumerable<Pairing> GetListPairingInTourRoundOfFederation(int roundID, int tourID, int federationID)
        {
            var pairings = _pairingRepository.GetListPairingInTourRoundOfFederation(roundID, tourID, federationID);
            foreach (var pair in pairings)
            {
                pair.PlayerInPairs = _playerInPairRepository.GetListPlayerInParing(pair.PairingID);
            }

            return pairings;
        }
    }
}