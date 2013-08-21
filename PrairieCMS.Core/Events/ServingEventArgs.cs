using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System;

//////
//http://dotnetblogengine.net
//////

namespace PrairieCMS.Core.Events
{
    /// <summary>
    /// Used when a post is served to the output stream.
    /// </summary>
    public class ServingEventArgs : EventArgs
    {

        /// <summary>
        /// Creates a new instance of the class and applies the specified body.
        /// </summary>
        public ServingEventArgs(string body, ServingLocation location)
        {
            _Body = body;
            _Location = location;
        }

        private string _Body;
        /// <summary>
        /// Gets or sets the body of the post. If you change the Body, 
        /// then that change will be shown on the web page.
        /// </summary>
        public string Body
        {
            get { return _Body; }
            set { _Body = value; }
        }

        private ServingLocation _Location;
        /// <summary>
        /// The location where the serving takes place.
        /// </summary>
        public ServingLocation Location
        {
            get { return _Location; }
            set { _Location = value; }
        }

        private bool _Cancel;
        /// <summary>
        /// Cancels the serving of the content.
        /// <remarks>If the serving is cancelled then the item will not be displayed.</remarks>
        /// </summary>
        public bool Cancel
        {
            get { return _Cancel; }
            set { _Cancel = value; }
        }

    }

    /// <summary>
    /// The location where the serving takes place
    /// </summary>
    public enum ServingLocation
    {
        /// <summary>Is used to indicate that a location hasn't been chosen.</summary>
        None,

        /// <summary>Is used when a single post is served from post.aspx.</summary>
        SinglePost,

        /// <summary>Is used when multiple posts are served using postlist.ascx.</summary>
        PostList,

        /// <summary>Is used when a single page is displayed on page.aspx.</summary>
        SinglePage,

        /// <summary>Is used when content is served from a feed (RSS or ATOM).</summary>
        Feed,

        /// <summary>Is used when content is being sent by e-mail.</summary>
        Email,

        /// <summary>Is used when content is served on a custom location.</summary>
        Other
    }
}
