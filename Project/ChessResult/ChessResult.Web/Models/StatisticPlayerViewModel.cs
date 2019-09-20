namespace ChessResult.Web.Models
{
    public class StatisticPlayerViewModel
    {
        public TournamentViewModel Tournament { get; set; }

        public PlayerViewModel Player { get; set; }

        public float TotalMark { get; set; }
    }
}