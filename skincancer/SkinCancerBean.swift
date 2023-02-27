
import Foundation

class SkinCancerBean {
	
  var errorList : [String] = [String]()

  init() {
  	 //init
  }

  func resetData() { 
  	errorList = [String]()
  }

  func isCreateSkinCancerError(id: String, dates: String, images: String, outcome: String) -> Bool { 
  	resetData() 
  	if id == "" {
  		errorList.append("id cannot be empty")
  	}
  	if dates == "" {
  		errorList.append("dates cannot be empty")
  	}
  	if images == "" {
  		errorList.append("images cannot be empty")
  	}
  	if outcome == "" {
  		errorList.append("outcome cannot be empty")
  	}

    return errorList.count > 0
  }

  func isEditSkinCancerError() -> Bool
    { return false }
          
  func isListSkinCancerError() -> Bool {
    resetData() 
    return false
  }
  
   func isDeleteSkinCancererror() -> Bool
     { return false }

  func errors() -> String {
    var res : String = ""
    for (_,x) in errorList.enumerated()
    { res = res + x + ", " }
    return res
  }

}
