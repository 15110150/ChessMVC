using System.Collections.Generic;
using ChessResult.Model.Model;

namespace ChessResult.Service.Infrastucture
{
    public interface IRoundService
    {
        IEnumerable<Round> GetListRoundByTournament(int id);

        IEnumerable<Round> GetAllRoundPairingInTournament(int id);
    }
}