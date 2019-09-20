using System.Collections.Generic;
using ChessResult.Model.Model;
using ChessResult.Repository.Infrastructure;
using ChessResult.Service.Infrastucture;

namespace ChessResult.Service.Services
{
    public class PlayerInPairService : IPlayerInPairService
    {
        private readonly IPlayerInPairRepository _playerInPairRepository;

        public PlayerInPairService(IPlayerInPairRepository playerInPairRepository)
        {
            _playerInPairRepository = playerInPairRepository;
        }

        public IEnumerable<PlayerInPair> GetListPlayerInParing(int pairingID)
        {
            return _playerInPairRepository.GetListPlayerInParing(pairingID);
        }
    }
}