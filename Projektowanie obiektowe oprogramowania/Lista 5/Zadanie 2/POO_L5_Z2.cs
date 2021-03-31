using System;
using System.IO;
using System.Text;

namespace POO_L5_Z2 {
    class CaesarStream : Stream {
        Stream stream;
        int shift_offset;
        public CaesarStream(Stream stream, int shift_offset) {
            this.stream = stream;
            this.shift_offset = shift_offset;
        }
        public override void Write(byte[] buffer, int offset, int count) {
            //Console.WriteLine("Write: offset - {0}", offset);
            //var newBuffer=new byte[buffer.Length]
            for (int i=0; i<buffer.Length; i++) {
                //Console.WriteLine("----------");
                //Console.WriteLine(buffer [i]);
                buffer[i] = (byte)(((int)buffer[i] + shift_offset) % 255);
                //Console.WriteLine(buffer[i]);
            }
            stream.Write(buffer, offset, count);
        } 
        public override int Read(byte[] buffer, int offset, int count) {
            int res=stream.Read(buffer, offset, count);
            for (int i=0; i<buffer.Length; i++) {
                buffer[i] = (byte)(((int)buffer[i] + shift_offset) % 255);
            }
            return res;
        } 

        public override long Seek(long offset, SeekOrigin origin) {
            return this.stream.Seek(offset, origin);
        }
        
        public override void Flush() {
            this.stream.Flush();
        }
        
        public override void SetLength(long length) {
            this.stream.SetLength(length);
        }
        
        public override bool CanWrite {
            get { return this.stream.CanWrite; }
        } 

        public override bool CanRead  {
            get { return this.stream.CanRead; }
        }

        public override bool CanSeek {
            get { return this.stream.CanSeek; }
        }
        public override long Length {
            get { return this.stream.Length; }
        }
        public override long Position {
            get { return this.stream.Position; }
            set { this.stream.Position=value; }
        }
    }
    class Test {
        public static void Main() {
            
            String s = "Napis do zaszyfrowania";
            FileStream fileToWrite = File.Create("test_file.txt");
            CaesarStream caeToWrite = new CaesarStream( fileToWrite, 5 );
            caeToWrite.Write( Encoding.UTF8.GetBytes(s));
            fileToWrite.Close();
            
            FileStream fileToRead = File.OpenRead("test_file.txt");
            CaesarStream caeToRead = new CaesarStream( fileToRead, -5 );
            var bytes = new byte[100];
            caeToRead.Read(bytes);
            
            Console.WriteLine("Odczytano: {0}", Encoding.UTF8.GetString(bytes));
        }
    }  
}