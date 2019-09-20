using System.Collections.Generic;
using ChessResult.Model.DTO;
using ChessResult.Model.Model;

namespace ChessResult.Repository.Infrastructure
{
    public interface IPlayerRepository : IRepository<Player>
    {
        IEnumerable<StatisticPlayer> GetListPlayerHigherMarkInTournament(int id);

        IEnumerable<Player> GetListPlayerOfFederationInTournament(int tourID, int federationID);
    }
}