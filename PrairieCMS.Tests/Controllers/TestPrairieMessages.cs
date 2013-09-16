using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace PrairieCMS.Tests.Controllers
{
    [TestClass]
    public class TestPrairieMessages
    {
        [TestMethod]
        public void TestGetMessages()
        {
            string messagesstring = new PrairieMessages.MessagesController().GetContent();
            Assert.IsTrue(!string.IsNullOrEmpty(messagesstring));
        }

        [TestMethod]
        public void TestGetAdmin()
        {
            string messagesstring = new PrairieMessages.MessagesController().GetAdminPages();
            Assert.IsTrue(!string.IsNullOrEmpty(messagesstring));
        }
    }
}
