using ChessResult.Model.Abstract;

namespace ChessResult.Model.Model
{
    public class Group : Record
    {
        public int ID { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }
    }
}