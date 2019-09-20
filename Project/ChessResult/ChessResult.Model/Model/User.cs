using ChessResult.Model.Abstract;

namespace ChessResult.Model.Model
{
    public class User : Record
    {
        public int ID { get; set; }

        public string UserName { get; set; }

        public string Password { get; set; }

        public int RoleID { get; set; }

        public Role Role { get; set; }
    }
}