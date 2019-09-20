using System.Collections.Generic;
using ChessResult.Model.Model;

namespace ChessResult.Service.Infrastucture
{
    public interface IRoleService
    {
        IEnumerable<Role> GetAll();

        Role GetRoleOfUser(int id);
    }
}