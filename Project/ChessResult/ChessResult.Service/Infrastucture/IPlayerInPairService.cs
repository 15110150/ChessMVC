using System.Collections.Generic;
using ChessResult.Model.Model;

namespace ChessResult.Service.Infrastucture
{
    public interface IPlayerInPairService
    {
        IEnumerable<PlayerInPair> GetListPlayerInParing(int pairingID);
    }
}