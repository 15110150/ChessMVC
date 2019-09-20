using ChessResult.Model.Abstract;

namespace ChessResult.Model.Model
{
    public class Form : Record
    {
        public int ID { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }
    }
}