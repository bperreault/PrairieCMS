using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Threading;
using System.Web.Mvc;
using WebMatrix.WebData;
using PrairieCMS.Models;
using System.Web.Security;

namespace PrairieCMS.Filters
{
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method, AllowMultiple = false, Inherited = true)]
    public sealed class InitializeSimpleMembershipAttribute : ActionFilterAttribute
    {
        private static SimpleMembershipInitializer _initializer;
        private static object _initializerLock = new object();
        private static bool _isInitialized;

        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            // Ensure ASP.NET Simple Membership is initialized only once per app start
            LazyInitializer.EnsureInitialized(ref _initializer, ref _isInitialized, ref _initializerLock);
        }

        private class SimpleMembershipInitializer
        {
            public SimpleMembershipInitializer()
            {
                Database.SetInitializer<UsersContext>(null);

                //try
                //{
                //the user on the web server didn't have rights to check if the database exists. so commenting this out.
                //using (var context = new UsersContext())
                //{
                //    if (!context.Database.Exists())
                //    {
                //        // Create the SimpleMembership database without Entity Framework migration schema
                //        ((IObjectContextAdapter)context).ObjectContext.CreateDatabase();
                //    }
                //}

                //}
                //catch (Exception ex)
                //{
                //    throw new InvalidOperationException("The ASP.NET Simple Membership database could not be initialized. For more information, please see http://go.microsoft.com/fwlink/?LinkId=256588", ex);
                //}

                WebSecurity.InitializeDatabaseConnection("PrairieCMSConnectionString", "Users", "UserId", "Username", autoCreateTables: true);

                var roles = (SimpleRoleProvider)Roles.Provider;
                var membership = (SimpleMembershipProvider)Membership.Provider;

                if (!roles.RoleExists("Admin"))
                {
                    roles.CreateRole("Admin");
                }
                //if (membership.GetUser("admin", false) == null)
                //{
                //    membership.CreateUserAndAccount("admin", "admin1");
                //    roles.AddUsersToRoles(new[] { "admin" }, new[] { "admin" });
                //}

            }
        }
    }
}
