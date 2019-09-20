using System;
using System.Collections.Generic;
using System.Linq;
using ChessResult.Model.DTO;
using ChessResult.Model.Model;
using ChessResult.Repository.Infrastructure;
using Fanex.Data;

namespace ChessResult.Repository.Repositories
{
    public class PlayerRepository : IPlayerRepository
    {
        public void Add(Player entity)
        {
            var param = new
            {
                Name = entity.Name,
                BirthDate = entity.BirthDate,
                Image = entity.Image,
                Sex = entity.Sex,
                FederationID = entity.Federation.ID,
            };

            using (IObjectDb db = ObjectDbFactory.CreateInstance("CreatePlayer"))
            {
                db.ExecuteNonQuery(param);
            }
        }

        public void Delete(int id)
        {
            var parameter = new
            {
                ID = id
            };

            using (var objectDb = ObjectDbFactory.CreateInstance("DeletePlayer"))
            {
                objectDb.Query<Player>(parameter);
            }
        }

        public IEnumerable<Player> GetAll()
        {
            using (IObjectDb db = ObjectDbFactory.CreateInstance("GetAllPlayer"))
            {
                return db.Query<Player>();
            }
        }

        public Player GetById(int id)
        {
            const string splitOn = "FederationID";
            var parameter = new
            {
                ID = id.ToString()
            };

            using (var objectDb = ObjectDbFactory.CreateInstance("GetPlayerByID"))
            {
                return objectDb.Query<Player, Federation, Player>(
                    (player, federation) =>
                    {
                        player.Federation = federation;
                        return player;
                    },
                    splitOn,
                    parameter)
                    .FirstOrDefault();
            }
        }

        public IEnumerable<StatisticPlayer> GetListPlayerHigherMarkInTournament(int id)
        {
            const string splitOn = "FederationID, TournamentID, TotalMark";
            var parameter = new
            {
                TourID = id.ToString()
            };

            using (var objectDb = ObjectDbFactory.CreateInstance("GetListPlayerHigherMarkInTournament"))
            {
                return objectDb.Query<Player, Federation, Tournament, StatisticPlayer, StatisticPlayer>(
                  (player, federation, tournament, statisticPlayer) =>
                  {
                      statisticPlayer.Player = player;
                      statisticPlayer.Player.Federation = federation;
                      statisticPlayer.Tournament = tournament;
                      return statisticPlayer;
                  },
                  splitOn,
                  parameter);
            }
        }

        public IEnumerable<Player> GetListPlayerOfFederationInTournament(int tourID, int federationID)
        {
            const string splitOn = "FederationID";
            var parameter = new
            {
                TourID = tourID.ToString(),
                FederationID = federationID.ToString()
            };

            using (var objectDb = ObjectDbFactory.CreateInstance("GetPlayerInTournamentByFederation"))
            {
                return objectDb.Query<Player, Federation, Player>(
                    (player, federation) =>
                    {
                        player.Federation = federation;
                        return player;
                    },
                    splitOn,
                    parameter);
            }
        }

        public void Update(Player entity)
        {
            throw new NotImplementedException();
        }
    }
}