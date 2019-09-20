using System.Collections.Generic;
using ChessResult.Model.Model;

namespace ChessResult.Service.Infrastucture
{
    public interface IPlayerService
    {
        Player GetPlayerByID(int id);

        IEnumerable<Player> GetListPlayerOfFederationInTournament(int tourID, int federationID);
    }
}