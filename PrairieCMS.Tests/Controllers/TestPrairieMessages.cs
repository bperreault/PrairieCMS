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
    }
}
