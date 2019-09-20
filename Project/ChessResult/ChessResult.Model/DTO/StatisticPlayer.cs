using ChessResult.Model.Model;

namespace ChessResult.Model.DTO
{
    public class StatisticPlayer
    {
        public Tournament Tournament { get; set; }

        public Player Player { get; set; }

        public float TotalMark { get; set; }
    }
}