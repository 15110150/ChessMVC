using System;
using System.Collections.Generic;
using System.Linq;
using ChessResult.Model.Model;
using ChessResult.Repository.Infrastructure;
using Fanex.Data;

namespace ChessResult.Repository.Repositories
{
    public class RoleRepository : IRoleRepository
    {
        public void Add(Role entity)
        {
            throw new NotImplementedException();
        }

        public void Delete(int id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Role> GetAll()
        {
            using (var objectDb = ObjectDbFactory.CreateInstance("GetAllRole"))
            {
                return objectDb.Query<Role>();
            }
        }

        public Role GetById(int id)
        {
            throw new NotImplementedException();
        }

        public Role GetRoleUser(int id)
        {
            var parameter = new
            {
                UserID = id
            };

            using (var objectDb = ObjectDbFactory.CreateInstance("GetRoleOfUser"))
            {
                return objectDb.Query<Role>(parameter).FirstOrDefault();
            }
        }

        public void Update(Role entity)
        {
            throw new NotImplementedException();
        }
    }
}