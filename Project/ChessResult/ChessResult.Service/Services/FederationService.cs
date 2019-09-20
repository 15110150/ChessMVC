using System.Collections.Generic;
using ChessResult.Model.Model;
using ChessResult.Repository.Infrastructure;
using ChessResult.Service.Infrastucture;

namespace ChessResult.Service.Services
{
    public class FederationService : IFederationService
    {
        private readonly IFederationRepository _federationRepository;

        public FederationService(IFederationRepository federationRepository)
        {
            _federationRepository = federationRepository;
        }

        public IEnumerable<Federation> GetAll()
        {
            return _federationRepository.GetAll();
        }

        public IEnumerable<Federation> GetFederationInTournament(int id)
        {
            return _federationRepository.GetFederationInTournament(id);
        }
    }
}