using System.Collections.Generic;
using System.Linq;
using ChessResult.Model.Model;
using ChessResult.Repository.Infrastructure;
using Fanex.Data;

namespace ChessResult.Repository.Repositories
{
    public class FederationRepository : IFederationRepository
    {
        public void Add(Federation entity)
        {
            var parameter = new
            {
                Name = entity.Name,
                Flag = entity.Flag,
                Acronym = entity.Acronym
            };

            using (var objectDb = ObjectDbFactory.CreateInstance("CreateFederation"))
            {
                objectDb.Query<Federation>(parameter);
            }
        }

        public void Delete(int id)
        {
            var parameter = new
            {
                ID = id
            };

            using (var objectDb = ObjectDbFactory.CreateInstance("DeleteFederation"))
            {
                objectDb.Query<Federation>(parameter);
            }
        }

        public IEnumerable<Federation> GetAll()
        {
            using (var objectDb = ObjectDbFactory.CreateInstance("GetAllFederation"))
            {
                return objectDb.Query<Federation>().OrderBy(x => x.Name);
            }
        }

        public Federation GetById(int id)
        {
            var parameter = new
            {
                TourId = id.ToString(),
            };

            using (IObjectDb db = ObjectDbFactory.CreateInstance("GetSingle"))
            {
                return db.Query<Federation>(parameter).FirstOrDefault();
            }
        }

        public IEnumerable<Federation> GetFederationInTournament(int id)
        {
            var parameter = new
            {
                TourId = id.ToString(),
            };

            using (IObjectDb db = ObjectDbFactory.CreateInstance("GetFederationParticipate"))
            {
                return db.Query<Federation>(parameter);
            }
        }

        public void Update(Federation entity)
        {
            var parameter = new
            {
                ID = entity.ID,
                Name = entity.Name,
                Flag = entity.Flag,
                Acronym = entity.Acronym
            };

            using (var objectDb = ObjectDbFactory.CreateInstance("UpdateFederation"))
            {
                objectDb.Query<Federation>(parameter);
            }
        }
    }
}