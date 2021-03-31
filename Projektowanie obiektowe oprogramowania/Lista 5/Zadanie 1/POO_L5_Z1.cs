using System;
using System.IO;
using System.Net.Mail;

namespace POO_L5_Z1 {
    class SmtpFacade {
        public void Send(String From, String To, string Subject, string Body, Stream Attachment, string AttachmentMimeType) {
            try {
                MailMessage m=new MailMessage(From, To, Subject, Body);
                if (Attachment != null) {
                    Attachment a = new Attachment(Attachment, AttachmentMimeType);
                    m.Attachments.Add(a);
                }
                SmtpClient c=new SmtpClient();
                c.Send(m);
            }
            catch(Exception e) {
                Console.WriteLine("Error occured: {0}", e.Message);
            }
        }
    }
    class Test {
        public static void Main() {
            
        }
    }    
}