using ChessResult.Model.DTO;
using ChessResult.Model.Model;
using ChessResult.Web.Models;

namespace ChessResult.Web.Utilities
{
    public static class EntityExtension
    {
        public static void ConvertToTournament(this Tournament tournament, TournamentViewModel tournamentVM)
        {
            tournament.ID = tournamentVM.ID;
            tournament.Name = tournamentVM.Name;
            tournament.Organizer = tournamentVM.Organizer;
            tournament.StartDate = tournamentVM.StartDate;
            tournament.EndDate = tournamentVM.EndDate;
            tournament.FederationID = tournamentVM.FederationID;
            tournament.FormID = tournamentVM.FormID;
            tournament.Location = tournamentVM.Location;
            tournament.Description = tournamentVM.Description;
            tournament.Director = tournamentVM.Director;
            tournament.ParentTourID = tournamentVM.ParentTourID;
            tournament.Status = tournamentVM.Status;
            tournament.UpdatedDate = tournamentVM.UpdatedDate;
            tournament.UpdatedBy = tournamentVM.UpdatedBy;
            tournament.CreatedDate = tournamentVM.CreatedDate;
            tournament.CreatedBy = tournamentVM.CreatedBy;
        }

        public static void ConvertToUser(this User user, UserViewModel userVM)
        {
            user.ID = userVM.ID;
            user.UserName = userVM.UserName;
            user.Password = userVM.Password;
            user.RoleID = userVM.RoleID;
            user.Status = userVM.Status;
            user.CreatedDate = userVM.CreatedDate;
            user.UpdatedDate = userVM.UpdatedDate;
        }

        public static void ConvertToUser(this User user, RegisterViewModel registerVM)
        {
            user.UserName = registerVM.UserName;
            user.Password = registerVM.Password;
        }

        public static void ConvertToTournametFilter(this TournamentFilter tournamentFilter, TournamentFillterViewModel tournamentFilterVM)
        {
            tournamentFilter.Name = tournamentFilterVM.Name;
            tournamentFilter.StartDate = tournamentFilterVM.StartDate;
            tournamentFilter.FederationID = tournamentFilterVM.FederationID;
        }
    }
}