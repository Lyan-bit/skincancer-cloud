
import Foundation

class ImageRecognitionVO {
  var skinCancer : String = ""

  static var defaultInstance : ImageRecognitionVO? = nil
  var errorList : [String] = [String]()

  var result : String = ""

  init() {
  	//init
  }
  
  static func defaultImageRecognitionVO() -> ImageRecognitionVO
  { if defaultInstance == nil
    { defaultInstance = ImageRecognitionVO() }
    return defaultInstance!
  }

  init(skinCancerx: String)  {
  skinCancer = skinCancerx
  }

  func toString() -> String
  	{ return "" + "skinCancer = " + skinCancer }

  func getSkinCancer() -> SkinCancer
  	{ return SkinCancer.skinCancerIndex[skinCancer]! }
  	
  func setSkinCancer(x : SkinCancer)
  	{ skinCancer = x.id }
			  
  func setResult (x: String) {
    result = x }
          
  func resetData()
  	{ errorList = [String]() }

  func isImageRecognitionError() -> Bool
  	{ resetData()
  
 if SkinCancer.skinCancerIndex[skinCancer] == nil
	{ errorList.append("Invalid skinCancer id: " + skinCancer) }


    if errorList.count > 0
    { return true }
    
    return false
  }

  func errors() -> String
  { var res : String = ""
    for (_,x) in errorList.enumerated()
    { res = res + x + ", " }
    return res
  }

}

