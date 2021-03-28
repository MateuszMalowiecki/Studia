using System;
using System.Net.Mail;

namespace POO_L5_Z1 {
    class SmtpFacade {
        public void Send(String From, String To, string Subject, string Body, Stream Attachment, string AttachmentMimeType) {
            MailMessage m=new MailMessage(From, To, Subject, Body);
            if (Attachment != null) {
                Attachment a = new Attachment(Attachment, AttachmentMimeType);
                m.Attachments.Add(a);
            }
            SmtpClient c=new SmtpClient();
            try {
                c.Send(m);
            }
            catch(Exception e) {
                Console.Writeline(e);
            }
        }
        class Test {
            public static void Main() {}
        }
    }    
}