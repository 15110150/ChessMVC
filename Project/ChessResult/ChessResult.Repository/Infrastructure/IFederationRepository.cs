using System.Collections.Generic;
using ChessResult.Model.Model;

namespace ChessResult.Repository.Infrastructure
{
    public interface IFederationRepository : IRepository<Federation>
    {
        IEnumerable<Federation> GetFederationInTournament(int id);
    }
}