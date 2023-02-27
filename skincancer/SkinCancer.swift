
import Foundation

class SkinCancer : Decodable {
	
  private static var instance : SkinCancer? = nil	
  
  init() { 
  	//init
  }
  
  init(copyFrom: SkinCancer) {
  	self.id = "copy" + copyFrom.id
  	self.dates = copyFrom.dates
  	self.images = copyFrom.images
  	self.outcome = copyFrom.outcome
  }
  
  func copy() -> SkinCancer
  { let res : SkinCancer = SkinCancer(copyFrom: self)
  	addSkinCancer(instance: res)
  	return res
  }
  
static func defaultInstanceSkinCancer() -> SkinCancer
    { if (instance == nil)
    { instance = createSkinCancer() }
    return instance!
}

deinit
{ killSkinCancer(obj: self) }	


  var id: String = ""  /* primary key */
  var dates: String = "" 
  var images: String = "" 
  var outcome: String = "" 

  static var skinCancerIndex : Dictionary<String,SkinCancer> = [String:SkinCancer]()

  static func getByPKSkinCancer(index : String) -> SkinCancer?
  { return skinCancerIndex[index] }


}

  var SkinCancerAllInstances : [SkinCancer] = [SkinCancer]()

  func createSkinCancer() -> SkinCancer
	{ let result : SkinCancer = SkinCancer()
	  SkinCancerAllInstances.append(result)
	  return result }
  
  func addSkinCancer(instance : SkinCancer)
	{ SkinCancerAllInstances.append(instance) }

  func killSkinCancer(obj: SkinCancer)
	{ SkinCancerAllInstances = SkinCancerAllInstances.filter{ $0 !== obj } }

  func createByPKSkinCancer(key : String) -> SkinCancer
	{ var result : SkinCancer? = SkinCancer.getByPKSkinCancer(index: key)
	  if result != nil { 
	  	return result!
	  }
	  result = SkinCancer()
	  SkinCancerAllInstances.append(result!)
	  SkinCancer.skinCancerIndex[key] = result!
	  result!.id = key
	  return result! }

  func killSkinCancer(key : String)
	{ SkinCancer.skinCancerIndex[key] = nil
	  SkinCancerAllInstances.removeAll(where: { $0.id == key })
	}
	
	extension SkinCancer : Hashable, Identifiable
	{ 
	  static func == (lhs: SkinCancer, rhs: SkinCancer) -> Bool
	  {       lhs.id == rhs.id &&
      lhs.dates == rhs.dates &&
      lhs.images == rhs.images &&
      lhs.outcome == rhs.outcome
	  }
	
	  func hash(into hasher: inout Hasher) {
    	hasher.combine(id)
    	hasher.combine(dates)
    	hasher.combine(images)
    	hasher.combine(outcome)
	  }
	}
	

