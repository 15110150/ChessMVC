using System.Collections.Generic;
using System.Linq;
using ChessResult.Model.DTO;
using ChessResult.Model.Model;
using ChessResult.Repository.Infrastructure;
using Fanex.Data;

namespace ChessResult.Repository.Repositories
{
    public class TournamentRepository : ITournamentRepository
    {
        public void Add(Tournament entity)
        {
            var parameters = new
            {
                Name = entity.Name,
                FederationID = entity.FederationID,
                StartDate = entity.StartDate,
                EndDate = entity.EndDate,
                Location = entity.Location,
                Organizer = entity.Organizer,
                Director = entity.Director,
                Description = entity.Description,
                ParentTourID = entity.ParentTourID,
                Status = 1
            };

            using (var objectDb = ObjectDbFactory.CreateInstance("AddTournament"))
            {
                objectDb.ExecuteNonQuery(parameters);
            }
        }

        public void Delete(int id)
        {
            var parameter = new
            {
                TourID = id
            };

            using (var objectDb = ObjectDbFactory.CreateInstance("DeleteTournament"))
            {
                objectDb.Query<Tournament>(parameter);
            }
        }

        public IEnumerable<Tournament> GetAll()
        {
            const string splitOn = "FederationID";

            using (var objectDb = ObjectDbFactory.CreateInstance("GetAllTournament"))
            {
                return objectDb.Query<Tournament, Federation, Tournament>(
                  (tournament, federation) =>
                  {
                      tournament.Federation = federation;
                      return tournament;
                  },
                  splitOn);
            }
        }

        public IEnumerable<Tournament> GetAllChildTournament(int id)
        {
            const string splitOn = "TournamentID";
            var parameter = new
            {
                TourID = id.ToString(),
            };

            using (var objectDb = ObjectDbFactory.CreateInstance("GetChildTournament"))
            {
                return objectDb.Query<Form, Tournament, Tournament>(
                  (form, tournaments) =>
                  {
                      tournaments.Form = form;
                      return tournaments;
                  },
                  splitOn,
                  parameter);
            }
        }

        public Tournament GetById(int id)
        {
            const string splitOn = "FederationID";
            var parameter = new
            {
                Id = id.ToString(),
            };

            using (var objectDb = ObjectDbFactory.CreateInstance("GetSingle"))
            {
                return objectDb.Query<Tournament, Federation, Tournament>(
                  (tournaments, federation) =>
                  {
                      tournaments.Federation = federation;
                      return tournaments;
                  },
                  splitOn,
                  parameter).FirstOrDefault();
            }
        }

        public IEnumerable<Tournament> GetTournamentInProgress()
        {
            const string splitOn = "FederationID";

            using (var objectDb = ObjectDbFactory.CreateInstance("GetTournamentInProgress"))
            {
                var x = objectDb.Query<Tournament, Federation, Tournament>(
                  (tournament, federation) =>
                  {
                      tournament.Federation = federation;
                      return tournament;
                  },
                  splitOn);
                return x;
            }
        }

        public IEnumerable<Tournament> GetTournamentInProgressByFederation(int id)
        {
            const string splitOn = "FederationID";
            var parameter = new
            {
                FederationId = id.ToString()
            };

            using (var objectDb = ObjectDbFactory.CreateInstance("GetTournamentInProgressByFederation"))
            {
                return objectDb.Query<Tournament, Federation, Tournament>(
                  (tournament, federation) =>
                  {
                      tournament.Federation = federation;
                      return tournament;
                  },
                  splitOn,
                  parameter);
            }
        }

        public IEnumerable<Tournament> FindTournament(TournamentFilter filter)
        {
            const string splitOn = "FederationID";
            var parameters = new
            {
                Name = filter.Name,
                StartDate = filter.StartDate,
                FederationID = filter.FederationID
            };

            using (var objectDb = ObjectDbFactory.CreateInstance("SearchTournament"))
            {
                return objectDb.Query<Tournament, Federation, Tournament>(
                  (tournament, federation) =>
                  {
                      tournament.Federation = federation;
                      return tournament;
                  },
                  splitOn,
                  parameters);
            }
        }

        public void Update(Tournament entity)
        {
            var parameters = new
            {
                TourID = entity.ID,
                Name = entity.Name,
                FederationID = entity.FederationID,
                StartDate = entity.StartDate,
                EndDate = entity.EndDate,
                Location = entity.Location,
                Organizer = entity.Organizer,
                Director = entity.Director,
                Description = entity.Description,
                Status = 1
            };

            using (var objectDb = ObjectDbFactory.CreateInstance("UpdateTournament"))
            {
                objectDb.Query<Tournament>(parameters);
            }
        }

        public IEnumerable<Tournament> GetTournamentNotHaveChild()
        {
            using (var objectDb = ObjectDbFactory.CreateInstance("GetTournamentNotHaveChild"))
            {
                return objectDb.Query<Tournament>();
            }
        }
    }
}