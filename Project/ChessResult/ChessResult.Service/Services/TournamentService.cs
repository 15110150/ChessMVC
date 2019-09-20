using System;
using System.Collections.Generic;
using System.Linq;
using ChessResult.Model.DTO;
using ChessResult.Model.Model;
using ChessResult.Repository.Infrastructure;
using ChessResult.Service.Infrastucture;

namespace ChessResult.Service.Services
{
    public class TournamentService : ITournamentService
    {
        private readonly ITournamentRepository _tournamentRepository;
        private readonly IFederationRepository _federationRepository;
        private readonly IRoundRepository _roundRepository;
        private readonly IPlayerRepository _playerRepository;

        public TournamentService(
               ITournamentRepository tournamentRepository,
               IFederationRepository federationRepository,
               IRoundRepository roundRepository,
               IPlayerRepository playerRepository)
        {
            _tournamentRepository = tournamentRepository;
            _federationRepository = federationRepository;
            _roundRepository = roundRepository;
            _playerRepository = playerRepository;
        }

        public IEnumerable<Tournament> GetAll()
        {
            return _tournamentRepository.GetAll();
        }

        public Tournament GetByID(int id)
        {
            var tournament = _tournamentRepository.GetById(id);
            tournament.FederationPaticipate = _federationRepository.GetFederationInTournament(id);
            tournament.Rounds = _roundRepository.GetListRoundByTournament(id);
            tournament.ChildenTournament = _tournamentRepository.GetAllChildTournament(id);

            if (tournament.ChildenTournament != null && tournament.ChildenTournament.Count() != 0)
            {
                tournament.ChildenTournament = GetStatisticPlayerInChildTour(tournament.ChildenTournament);
            }
            else
            {
                tournament.StatisticPlayer = _playerRepository.GetListPlayerHigherMarkInTournament(id);
            }

            return tournament;
        }

        public IEnumerable<Tournament> GetTournamentInProgress()
        {
            return _tournamentRepository.GetTournamentInProgress();
        }

        public IEnumerable<Tournament> GetTournamentInProgressByFederation(int id)
        {
            return _tournamentRepository.GetTournamentInProgressByFederation(id);
        }

        public void AddTournament(Tournament tournament)
        {
            _tournamentRepository.Add(tournament);
        }

        public void UpdateTournament(Tournament tournament)
        {
            _tournamentRepository.Update(tournament);
        }

        public void DeleteTournament(int id)
        {
            _tournamentRepository.Delete(id);
        }

        public IEnumerable<Tournament> GetStatisticPlayerInChildTour(IEnumerable<Tournament> childTournament)
        {
            foreach (var child in childTournament)
            {
                child.StatisticPlayer = _playerRepository.GetListPlayerHigherMarkInTournament(child.ID);
            }

            return childTournament;
        }

        public IEnumerable<Tournament> FindTournament(TournamentFilter filter)
        {
            return _tournamentRepository.FindTournament(filter);
        }

        public IEnumerable<Tournament> GetTournamentNotHaveChild()
        {
            return _tournamentRepository.GetTournamentNotHaveChild();
        }
    }
}