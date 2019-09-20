using System.Collections.Generic;
using ChessResult.Model.Model;

namespace ChessResult.Repository.Infrastructure
{
    public interface IRoundRepository : IRepository<Round>
    {
        IEnumerable<Round> GetListRoundByTournament(int id);
    }
}