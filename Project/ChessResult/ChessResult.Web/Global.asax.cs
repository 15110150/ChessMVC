using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using ChessResult.Web.Mappings;
using Fanex.Data;

namespace ChessResult.Web
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            AutoMapperConfiguration.Configure();
            DbSettingProviderManager
              .StartNewSession()
              .UseDefaultConnectionStringProvider()
              .UseDefaultDbSettingProvider(Server.MapPath("~/App_Data"), enableWatching: true)
              .Run();
        }
    }
}
