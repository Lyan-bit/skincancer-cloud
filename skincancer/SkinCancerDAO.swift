import Foundation

class SkinCancerDAO
{ static func getURL(command : String?, pars : [String], values : [String]) -> String
  { var res : String = "base url for the data source"
    if command != nil
    { res = res + command! }
    if pars.count == 0
    { return res }
    res = res + "?"
    for (i,v) in pars.enumerated()
    { res = res + v + "=" + values[i]
      if i < pars.count - 1
      { res = res + "&" }
    }
    return res
  }

  static func isCached(id : String) -> Bool
    { let x : SkinCancer? = SkinCancer.skinCancerIndex[id]
    if x == nil 
    { return false }
    return true
  }

  static func getCachedInstance(id : String) -> SkinCancer
    { return SkinCancer.skinCancerIndex[id]! }

  static func parseCSV(line: String) -> SkinCancer?
  { if line.count == 0
    { return nil }
    let line1vals : [String] = Ocl.tokeniseCSV(line: line)
    var skinCancerx : SkinCancer? = nil
      skinCancerx = SkinCancer.skinCancerIndex[line1vals[0]]
    if skinCancerx == nil
    { skinCancerx = createByPKSkinCancer(key: line1vals[0]) }
    skinCancerx!.id = line1vals[0]
    skinCancerx!.dates = line1vals[1]
    skinCancerx!.images = line1vals[2]
    skinCancerx!.outcome = line1vals[3]

    return skinCancerx
  }

  static func parseJSON(obj : [String : AnyObject]?) -> SkinCancer?
  {

    if let jsonObj = obj
    { let id : String? = jsonObj["id"] as! String?
      var skinCancerx : SkinCancer? = SkinCancer.skinCancerIndex[id!]
      if (skinCancerx == nil)
      { skinCancerx = createByPKSkinCancer(key: id!) }

       skinCancerx!.id = jsonObj["id"] as! String
       skinCancerx!.dates = jsonObj["dates"] as! String
       skinCancerx!.images = jsonObj["images"] as! String
       skinCancerx!.outcome = jsonObj["outcome"] as! String
      return skinCancerx!
    }
    return nil
  }

  static func writeJSON(x : SkinCancer) -> NSDictionary
  { return [    
       "id": x.id as NSString, 
       "dates": x.dates as NSString, 
       "images": x.images as NSString, 
       "outcome": x.outcome as NSString
     ]
  } 

  static func makeFromCSV(lines: String) -> [SkinCancer]
  { var res : [SkinCancer] = [SkinCancer]()

    if lines.count == 0
    { return res }

    let rows : [String] = Ocl.parseCSVtable(rows: lines)

    for (_,row) in rows.enumerated()
    { if row.count == 0 {
    	//check
    }
      else
      { let x : SkinCancer? = parseCSV(line: row)
        if (x != nil)
        { res.append(x!) }
      }
    }
    return res
  }
}

