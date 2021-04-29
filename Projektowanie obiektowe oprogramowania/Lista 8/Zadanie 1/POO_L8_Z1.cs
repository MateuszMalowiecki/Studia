using System;
using System.IO;
using System.Net;
using System.Text;
using System.Collections.Concurrent;
using System.Threading;

namespace POO_L8_Z1 {
    public interface IFileCommand  {
        void Execute();
    }
    public class FTPDownloadCommand :IFileCommand {
        private Receiver r;
        string uri;
        public FTPDownloadCommand(string uri) {
            this.uri=uri;
            this.r=new Receiver();
        }
        public void Execute() {
            r.FTPDownload(uri);
        }
    }
    public class HTTPDownloadCommand :IFileCommand {
        private Receiver r;
        string uri;
        public HTTPDownloadCommand(string uri) {
            this.uri=uri;
            this.r=new Receiver();
        }
        public void Execute() {
            r.HTTPDownload(uri);            
        }
    }
    public class EmptyDownloadCommand :IFileCommand {
        private Receiver r;
        string fileName;
        int length;
        public EmptyDownloadCommand(string fileName, int length) {
            this.fileName=fileName;
            this.length=length;
            this.r=new Receiver();
        }
        public void Execute() {
            r.EmptyDownload(fileName, length);
        }
    }
    public class CopyDownloadCommand :IFileCommand {
        private Receiver r;
        string oldFileName;
        string newFileName;
        public CopyDownloadCommand(string oldFileName, string newFileName) {
            this.oldFileName=oldFileName;
            this.newFileName=newFileName;
            this.r=new Receiver();
        }
        public void Execute() {
            r.CopyDownload(oldFileName, newFileName);
        }
    }
    public class Receiver {
        public void FTPDownload(string uri) {
            FtpWebRequest req = (FtpWebRequest)WebRequest.Create(uri);
            req.Method = WebRequestMethods.Ftp.DownloadFile;
            FtpWebResponse resp = (FtpWebResponse)req.GetResponse();
            StreamReader strRead = new StreamReader(resp.GetResponseStream());
            Console.WriteLine(strRead.ReadToEnd());
        }
        public void HTTPDownload(string uri) {
            WebClient wc=new WebClient();
            string data = Encoding.ASCII.GetString(wc.DownloadData(uri));
            Console.WriteLine(data);
        }
        public void EmptyDownload(string fileName, int length) {
            Random r=new Random();
            for(int i = 0; i < length; i++) {
                File.WriteAllText(fileName, r.Next().ToString());
            } 
        }
        public void CopyDownload(string oldFileName, string newFileName) {
            File.Copy(oldFileName, newFileName); 
        }
    }
    public class Invoker {
        ConcurrentQueue<IFileCommand> commands;
        public Invoker() {
            commands= new ConcurrentQueue<IFileCommand>();
            Run();
        }
        private void Run() {
            Thread executor1=new Thread(executeCommand);
            Thread executor2=new Thread(executeCommand);
            executor1.Start();
            executor2.Start();
            while(true) {
                createCommand();
                Thread.Sleep(500);
            }
        }
        private void createCommand() {
            Random r = new Random();
            int commandNumber = r.Next(0, 4);
            IFileCommand command=null;
            switch (commandNumber){
                case 0:
                    command=new FTPDownloadCommand("Some file");
                    break;
                case 1:
                    command=new HTTPDownloadCommand("Some file");
                    break;
                case 2:
                    command=new EmptyDownloadCommand("Some file", 42);
                    break;
                default:
                    command=new CopyDownloadCommand("Some file", "Some other file");
                    break;
            }
            commands.Enqueue(command);
            Console.WriteLine("Added new command");
        }
        private void executeCommand() {
            while(true) {
                IFileCommand command=null;
                while(!this.commands.TryDequeue(out command)) {
                    Console.WriteLine("Waiting for command to execute");
                }
                command.Execute();
                Console.WriteLine("Executed command");
                Thread.Sleep(100);
            }
        }
    }
    public class Test {
        public static void Main() {

        }
    }
}