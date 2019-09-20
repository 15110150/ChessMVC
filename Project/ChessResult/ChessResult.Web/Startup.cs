using System.Reflection;
using System.Web.Mvc;
using Autofac;
using Autofac.Integration.Mvc;
using ChessResult.Repository.Repositories;
using ChessResult.Service.Services;
using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(ChessResult.Web.Startup))]

namespace ChessResult.Web
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
            ConfiAutofac(app);
        }

        public void ConfiAutofac(IAppBuilder app)
        {
            var builder = new ContainerBuilder();

            builder.RegisterControllers(Assembly.GetExecutingAssembly());

            // Repositories
            builder.RegisterAssemblyTypes(typeof(TournamentRepository).Assembly)
                .Where(t => t.Name.EndsWith("Repository", System.StringComparison.CurrentCulture))
                .AsImplementedInterfaces().InstancePerRequest();

            // Services
            builder.RegisterAssemblyTypes(typeof(TournamentService).Assembly)
               .Where(t => t.Name.EndsWith("Service", System.StringComparison.CurrentCulture))
               .AsImplementedInterfaces().InstancePerRequest();

            var container = builder.Build();
            DependencyResolver.SetResolver(new AutofacDependencyResolver(container));
        }
    }
}