namespace ChessResult.Web.Models
{
    public class PlayerInPairViewModel
    {
        public int PairingID { get; set; }

        public int PlayerID { get; set; }

        public bool IsWhite { get; set; }

        public float Mark { get; set; }

        public PairingViewModel Pairing { get; set; }

        public PlayerViewModel Player { get; set; }
    }
}