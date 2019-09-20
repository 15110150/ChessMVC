using System;
using System.Collections.Generic;
using System.Linq;
using ChessResult.Model.Enum;
using ChessResult.Model.Model;
using ChessResult.Repository.Infrastructure;
using Fanex.Data;

namespace ChessResult.Repository.Repositories
{
    public class UserRepository : IUserRepository
    {
        public void Add(User entity)
        {
            var param = new
            {
                UserName = entity.UserName,
                Password = entity.Password,
                RoleID = RoleType.Normal,
            };

            using (IObjectDb db = ObjectDbFactory.CreateInstance("CreateUser"))
            {
                db.ExecuteNonQuery(param);
            }
        }

        public User CheckUser(string userName, string passWord)
        {
            const string splitOn = "Name";
            var parameter = new
            {
                UserName = userName,
                PassWord = passWord
            };

            using (IObjectDb objectDb = ObjectDbFactory.CreateInstance("CheckUser"))
            {
                return objectDb.Query<User, Role, User>(
                  (user, role) =>
                  {
                      user.Role = role;
                      return user;
                  },
                  splitOn,
                  parameter)
                  .FirstOrDefault();
            }
        }

        public void Delete(int id)
        {
            throw new NotImplementedException();
        }

        public User FindUserName(string userName)
        {
            var parameter = new
            {
                UserName = userName
            };

            using (IObjectDb objectDb = ObjectDbFactory.CreateInstance("FindUserName"))
            {
                return objectDb.Query<User>(parameter).FirstOrDefault();
            }
        }

        public IEnumerable<User> GetAll()
        {
            throw new NotImplementedException();
        }

        public User GetById(int id)
        {
            throw new NotImplementedException();
        }

        public void Update(User entity)
        {
            throw new NotImplementedException();
        }
    }
}