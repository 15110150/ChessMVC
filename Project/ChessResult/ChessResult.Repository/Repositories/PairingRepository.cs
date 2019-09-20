using System;
using System.Collections.Generic;
using ChessResult.Model.Model;
using ChessResult.Repository.Infrastructure;
using Fanex.Data;

namespace ChessResult.Repository.Repositories
{
    public class PairingRepository : IPairingRepository
    {
        public void Add(Pairing entity)
        {
            throw new NotImplementedException();
        }

        public void Delete(int id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Pairing> GetAll()
        {
            throw new NotImplementedException();
        }

        public Pairing GetById(int id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Pairing> GetListPairingInTourRound(int roundID, int tourID)
        {
            var parameter = new
            {
                RoundID = roundID.ToString(),
                TourID = tourID.ToString()
            };

            using (var objectDb = ObjectDbFactory.CreateInstance("GetListPairingInTourRound"))
            {
                var pairing = objectDb.Query<Pairing>(parameter);

                return pairing;
            }
        }

        public IEnumerable<Pairing> GetListPairingInTourRoundOfFederation(int roundID, int tourID, int federationID)
        {
            var parameter = new
            {
                RoundID = roundID.ToString(),
                TourID = tourID.ToString(),
                FederationID = federationID.ToString()
            };

            using (var objectDb = ObjectDbFactory.CreateInstance("GetListPairingInTourRoundOfFederation"))
            {
                var pairing = objectDb.Query<Pairing>(parameter);

                return pairing;
            }
        }

        public void Update(Pairing entity)
        {
            throw new NotImplementedException();
        }
    }
}