
import Foundation

class SkinCancerVO : Hashable, Identifiable, Decodable, Encodable {

  var id: String = ""
  var dates: String = "" 
  var images: String = "" 
  var outcome: String = ""

  static var defaultInstance : SkinCancerVO? = nil
  var errorList : [String] = [String]()

  init() {
  	//init
  }

  static func defaultSkinCancerVO() -> SkinCancerVO
  { if defaultInstance == nil
    { defaultInstance = SkinCancerVO() }
    return defaultInstance!
  }

  init(idx: String, datesx: String, imagesx: String, outcomex: String)  {
    id = idx
    dates = datesx
    images = imagesx
    outcome = outcomex
  }

  init(x : SkinCancer)  {
    id = x.id
    dates = x.dates
    images = x.images
    outcome = x.outcome
  }

  func toString() -> String
  { return " id= \(id), dates= \(dates), images= \(images), outcome= \(outcome) "
  }

  func getId() -> String
	  { return id }
	
  func setId(x : String)
	  { id = x }
	  
  func getDates() -> String
	  { return dates }
	
  func setDates(x : String)
	  { dates = x }
	  
  func getImages() -> String
	  { return images }
	
  func setImages(x : String)
	  { images = x }
	  
  func getOutcome() -> String
	  { return outcome }
	
  func setOutcome(x : String)
	  { outcome = x }
	  

  static func == (lhs: SkinCancerVO, rhs: SkinCancerVO) -> Bool
  { return
      lhs.id == rhs.id &&
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
