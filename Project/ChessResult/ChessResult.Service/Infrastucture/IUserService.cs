using ChessResult.Model.Model;

namespace ChessResult.Service.Infrastucture
{
    public interface IUserService
    {
        User FindUser(User user);

        User FindUserName(string userName);

        void AddUser(User user);
    }
}