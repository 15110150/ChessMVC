using System;
using ChessResult.Model.Model;
using ChessResult.Repository.Infrastructure;
using ChessResult.Service.Infrastucture;

namespace ChessResult.Service.Services
{
    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;

        public UserService(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public void AddUser(User user)
        {
            _userRepository.Add(user);
        }

        public User FindUser(User user)
        {
            return _userRepository.CheckUser(user.UserName, user.Password);
        }

        public User FindUserName(string userName)
        {
            return _userRepository.FindUserName(userName);
        }
    }
}