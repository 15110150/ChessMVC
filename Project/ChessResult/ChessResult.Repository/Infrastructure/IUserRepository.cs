using ChessResult.Model.Model;

namespace ChessResult.Repository.Infrastructure
{
    public interface IUserRepository : IRepository<User>
    {
        User CheckUser(string userName, string passWord);

        User FindUserName(string userName);
    }
}