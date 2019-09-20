using System.Collections.Generic;
using ChessResult.Model.Model;

namespace ChessResult.Repository.Infrastructure
{
    public interface IPairingRepository : IRepository<Pairing>
    {
        IEnumerable<Pairing> GetListPairingInTourRound(int roundID, int tourID);

        IEnumerable<Pairing> GetListPairingInTourRoundOfFederation(int roundID, int tourID, int federationID);
    }
}