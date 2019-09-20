using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ChessResult.Web.Utilities
{
    public static class HttpSession
    {
        public static void SetSession(string sessionName, object value)
        {
            HttpContext.Current.Session[sessionName] = value;
        }

        public static T GetFromSession<T>(string sessionName)
        {
            return (T)HttpContext.Current.Session[sessionName];
        }
    }
}