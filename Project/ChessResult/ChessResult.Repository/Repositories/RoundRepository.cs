using System;
using System.Collections.Generic;
using ChessResult.Model.Model;
using ChessResult.Repository.Infrastructure;
using Fanex.Data;

namespace ChessResult.Repository.Repositories
{
    public class RoundRepository : IRoundRepository
    {
        public void Add(Round entity)
        {
            throw new NotImplementedException();
        }

        public void Delete(int id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Round> GetAll()
        {
            throw new NotImplementedException();
        }

        public Round GetById(int id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Round> GetListRoundByTournament(int id)
        {
            var parameter = new
            {
                TourID = id.ToString(),
            };

            using (IObjectDb db = ObjectDbFactory.CreateInstance("GetListRoundByTournament"))
            {
                return db.Query<Round>(parameter);
            }
        }

        public void Update(Round entity)
        {
            throw new NotImplementedException();
        }
    }
}