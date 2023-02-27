import Foundation
import Darwin

class FileAccessor
{
  init() { 
  	//init
  }

  static func createFile(filename : String) 
  { let fm = FileManager.default
    do
    { let path = try fm.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: false)
      let furl = path.appendingPathComponent(filename)
      try "".write(to: furl, atomically: true, encoding: .utf8)
    }
    catch { print("Unable to create file " + filename); }
  }

  static func fileExists(filename : String) -> Bool 
  { let filemgr = FileManager.default
    let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask) 
    let docsDir = dirPaths[0]
    let path = docsDir.appendingPathComponent(filename)
    var pathtext : String = ""
    do
    { pathtext =
        try String(contentsOf: path, encoding: .utf8)
    }
    catch { return false }
    return filemgr.fileExists(atPath: pathtext) 
  }

  static func fileExistsAbsolutePath(filename : String) -> Bool 
  { let filemgr = FileManager.default
    return filemgr.fileExists(atPath: filename) 
  }

  static func fileIsWritable(filename : String) -> Bool
  { let filemgr = FileManager.default
    let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask) 
    let docsDir = dirPaths[0]
    let path = docsDir.appendingPathComponent(filename)
    var pathtext : String = ""
    do
    { pathtext =
        try String(contentsOf: path, encoding: .utf8)
    }
    catch { return false }
    return filemgr.isWritableFile(atPath: pathtext) 
  }

  static func deleteFile(filename : String) -> String
  { let filemgr = FileManager.default
    let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask) 
    let docsDir = dirPaths[0]
    let path = docsDir.appendingPathComponent(filename) 
    var pathtext : String = ""
    do
    { pathtext =
        try String(contentsOf: path, encoding: .utf8)
    }
    catch { return "ERROR in filename" }
    do 
    { try filemgr.removeItem(atPath: pathtext) 
      return "Success" 
    } 
    catch let error 
    { return "Error: " + error.localizedDescription }
  }
  
  static func readFile(filename : String) -> [String]
  { var res : [String] = [String]()
    let filemgr = FileManager.default
    let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask) 
    let docsDir = dirPaths[0]
    let path = docsDir.appendingPathComponent(filename)
    do
    { let text = 
          try String(contentsOf: path, encoding: .utf8)
      res = Ocl.toLineSequence(str: text)
      return res
    }
    catch { return res } 
  }
  
  static func writeFile(filename : String, contents : [String])
  { var text : String = ""
    let filemgr = FileManager.default
    let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask) 
    let docsDir = dirPaths[0]
    let path = docsDir.appendingPathComponent(filename)
    for s in contents
    { text = text + s + "\n" } 

    do
    { let pathtext =
          try String(contentsOf: path, encoding: .utf8)

      let file: FileHandle? = FileHandle(forUpdatingAtPath: pathtext) 
      if file != nil 
      { let data = (text as NSString).data(using: String.Encoding.utf8.rawValue)
        file?.write(data!) 
        file?.closeFile() 
      }
    }
    catch { return }
  }
}

