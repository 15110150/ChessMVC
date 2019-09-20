using System.Collections.Generic;
using ChessResult.Model.Model;

namespace ChessResult.Service.Infrastucture
{
    public interface IFederationService
    {
        IEnumerable<Federation> GetAll();

        IEnumerable<Federation> GetFederationInTournament(int id);
    }
}