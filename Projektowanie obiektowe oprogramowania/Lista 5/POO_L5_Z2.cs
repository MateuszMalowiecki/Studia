using System;

namespace POO_L5_Z2 {
    class CaesarStream : Stream {
        Stream stream;
        int offset;
        public CaesarStream(Stream stream, int offset) {
            this.stream = stream;
            this.offset = offset;
        }
        public override void Write(byte[] buffer, int offset, int count) {
            for (int i=0; i<buffer.Length; i++) {
                buffer[i] = (byte)((int)buffer[i] + offset) % 255;
            }
            stream.Write(buffer, offset, count);
        } 
        public override int Write(byte[] buffer, int offset, int count) {
            int res=stream.Read(buffer, offset, count);
            for (int i=0; i<buffer.Length; i++) {
                buffer[i] = (byte)((int)buffer[i] + offset) % 255
            }
            return res;
        } 

    }
}