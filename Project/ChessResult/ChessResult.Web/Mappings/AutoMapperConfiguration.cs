using AutoMapper;
using ChessResult.Model.Model;
using ChessResult.Web.Models;

namespace ChessResult.Web.Mappings
{
    public static class AutoMapperConfiguration
    {
        public static void Configure()
        {
            Mapper.Initialize(cfg =>
            {
                cfg.AllowNullCollections = true;
                cfg.CreateMap<Federation, FederationViewModel>();
                cfg.CreateMap<Form, FormViewModel>();
                cfg.CreateMap<Group, GroupViewModel>();
                cfg.CreateMap<Pairing, PairingViewModel>();
                cfg.CreateMap<PlayerInPair, PlayerInPairViewModel>();
                cfg.CreateMap<Player, PlayerViewModel>();
                cfg.CreateMap<Role, RoleViewModel>();
                cfg.CreateMap<Round, RoundViewModel>();
                cfg.CreateMap<Tournament, TournamentViewModel>();
                cfg.CreateMap<User, UserViewModel>();
            });
        }
    }
}