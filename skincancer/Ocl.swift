//
//  Ocl.swift
//  cdoapp
//
//  Created by Kevin Lano on 07/09/2021.
//

import Foundation
import Darwin

class Ocl
{
   static func toLineSequence(str: String) -> [String]
   { var result : [String] = [String]()
     var buffer : String = ""
     
     for index in str.indices
     { let c : Character = str[index]
       if "\n" == String(c)
       { result.append(buffer)
         buffer = String()
       }
       else
       { buffer = buffer + String(c) }
     }
     result.append(buffer)
     return result
   }
    
  static func tokeniseCSV(line: String) -> [String]
  { // Assumes the separator is a comma
    var buff : String = ""
    var instring : Bool = false
    var res : [String] = [String]()
   
    for x in line.indices
    { let chr : Character = line[x]
      if chr == ","
      { if instring
        { buff = buff + String(chr) }
        else
        { res.append(buff)
          buff = String()
        }
      }
      else if "\"" == chr
      { if instring
        { instring = false }
        else
        { instring = true }
      }
      else
      { buff = buff + String(chr) }
    }
    res.append(buff)
    return res
  }

  static func parseCSVtable(rows: String) -> [String]
  { var buff : String = ""
    var ind : Int = 0
    // var len : Int = rows.count
    // var instring : Bool = false
    var res : [String] = [String]()
   
    // Ignore the first row: column names
    
    for x in rows.indices
    { let chr : Character = rows[x]
      if chr == "\n" && ind > 0
      { res.append(buff)
        buff = String()
        ind = ind + 1
      }
      else if chr == "\n"
      { ind = ind + 1
        buff = String()
      }
      else
      { buff = buff + String(chr) }
    }
    res.append(buff)
    return res
  }
}

