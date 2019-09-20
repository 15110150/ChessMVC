using ChessResult.Model.Model;

namespace ChessResult.Repository.Infrastructure
{
    public interface IRoleRepository : IRepository<Role>
    {
        Role GetRoleUser(int id);
    }
}