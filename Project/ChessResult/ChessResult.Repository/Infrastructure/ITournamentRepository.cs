using System.Collections.Generic;
using System.Threading.Tasks;
using ChessResult.Model.DTO;
using ChessResult.Model.Model;

namespace ChessResult.Repository.Infrastructure
{
    public interface ITournamentRepository : IRepository<Tournament>
    {
        IEnumerable<Tournament> GetTournamentInProgress();

        IEnumerable<Tournament> GetTournamentInProgressByFederation(int id);

        IEnumerable<Tournament> GetAllChildTournament(int id);

        IEnumerable<Tournament> GetTournamentNotHaveChild();

        IEnumerable<Tournament> FindTournament(TournamentFilter filter);
    }
}