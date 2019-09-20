using System.Collections.Generic;
using ChessResult.Model.DTO;
using ChessResult.Model.Model;

namespace ChessResult.Service.Infrastucture
{
    public interface ITournamentService
    {
        void AddTournament(Tournament tournament);

        void UpdateTournament(Tournament tournament);

        void DeleteTournament(int id);

        IEnumerable<Tournament> FindTournament(TournamentFilter filter);

        IEnumerable<Tournament> GetAll();

        Tournament GetByID(int id);

        IEnumerable<Tournament> GetTournamentInProgress();

        IEnumerable<Tournament> GetTournamentInProgressByFederation(int id);

        IEnumerable<Tournament> GetStatisticPlayerInChildTour(IEnumerable<Tournament> childTournament);

        IEnumerable<Tournament> GetTournamentNotHaveChild();
    }
}