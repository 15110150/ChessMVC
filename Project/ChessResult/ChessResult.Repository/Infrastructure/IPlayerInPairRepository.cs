using System.Collections.Generic;
using ChessResult.Model.Model;

namespace ChessResult.Repository.Infrastructure
{
    public interface IPlayerInPairRepository : IRepository<PlayerInPair>
    {
        IEnumerable<PlayerInPair> GetListPlayerInParing(int pairingID);
    }
}