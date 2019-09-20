using System;
using System.Collections.Generic;
using ChessResult.Model.Model;
using ChessResult.Repository.Infrastructure;
using Fanex.Data;

namespace ChessResult.Repository.Repositories
{
    public class PlayerInPairRepository : IPlayerInPairRepository
    {
        public void Add(PlayerInPair entity)
        {
            throw new NotImplementedException();
        }

        public void Delete(int id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlayerInPair> GetAll()
        {
            throw new NotImplementedException();
        }

        public PlayerInPair GetById(int id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlayerInPair> GetListPlayerInParing(int pairingID)
        {
            const string splitOn = "Name, Flag";
            var parameter = new
            {
                PairingID = pairingID.ToString(),
            };

            using (var objectDb = ObjectDbFactory.CreateInstance("GetListPlayerInPairByPairingID"))
            {
                return objectDb.Query<PlayerInPair, Player, Federation, PlayerInPair>(
                  (playerInPair, player, federation) =>
                  {
                      playerInPair.Player = player;
                      playerInPair.Player.Federation = federation;
                      return playerInPair;
                  },
                  splitOn,
                  parameter);
            }
        }

        public void Update(PlayerInPair entity)
        {
            throw new NotImplementedException();
        }
    }
}