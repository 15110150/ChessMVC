using System.Collections.Generic;
using ChessResult.Model.Model;

namespace ChessResult.Service.Infrastucture
{
    public interface IPairingService
    {
        IEnumerable<Pairing> GetListPairingInTourRound(int roundID, int tourID);

        IEnumerable<Pairing> GetListPairingInTourRoundOfFederation(int roundID, int tourID, int federationID);
    }
}