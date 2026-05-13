using System;
using System.IO;
using System.Text;

class WriteFiles {
    static void Main() {
        string dir = @"D:\workfordasan\backend\src\main\java\com\labex\labexagent\service";
        Directory.CreateDirectory(dir);
        File.WriteAllText(Path.Combine(dir, "_test.txt"), "hello", Encoding.UTF8);
    }
}
