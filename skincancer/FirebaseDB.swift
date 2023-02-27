import UIKit
import FirebaseAuth
import FirebaseDatabase

class FirebaseDB
{ static var instance : FirebaseDB? = nil
  var database : DatabaseReference? = nil

  static func getInstance() -> FirebaseDB
  { if instance == nil
    { instance = FirebaseDB() }
    return instance!
  }

  init() {
	  //cloud database link
      connectByURL("https://patient-161e1-default-rtdb.europe-west1.firebasedatabase.app/")
  }

  func connectByURL(_ url: String)
  { self.database = Database.database(url: url).reference()
    if self.database == nil
    { print("Invalid database url")
      return
    }
    self.database?.child("skinCancers").observe(.value,
      with:
      { (change) in
        var keys : [String] = [String]()
        if let d = change.value as? [String : AnyObject]
        { for (_,v) in d.enumerated()
          { let einst = v.1 as! [String : AnyObject]
            let ex : SkinCancer? = SkinCancerDAO.parseJSON(obj: einst)
            keys.append(ex!.id)
          }
        }
        var runtimeskinCancers : [SkinCancer] = [SkinCancer]()
        runtimeskinCancers.append(contentsOf: SkinCancerAllInstances)

        for (_,obj) in runtimeskinCancers.enumerated()
        { if keys.contains(obj.id) {
        	//check
        }
          else
          { killSkinCancer(key: obj.id) }
        }
      })
  }

func persistSkinCancer(x: SkinCancer)
{ let evo = SkinCancerDAO.writeJSON(x: x) 
  if let newChild = self.database?.child("skinCancers").child(x.id)
  { newChild.setValue(evo) }
}

func deleteSkinCancer(x: SkinCancer)
{ if let oldChild = self.database?.child("skinCancers").child(x.id)
  { oldChild.removeValue() }
}

}
