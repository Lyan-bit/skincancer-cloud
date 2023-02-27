	                  
import Foundation
import SwiftUI

/* This code requires OclFile.swift */

func initialiseOclFile()
{ 
  //let systemIn = createByPKOclFile(key: "System.in")
  //let systemOut = createByPKOclFile(key: "System.out")
  //let systemErr = createByPKOclFile(key: "System.err")
}

/* This metatype code requires OclType.swift */

func initialiseOclType()
{ let intOclType = createByPKOclType(key: "int")
  intOclType.actualMetatype = Int.self
  let doubleOclType = createByPKOclType(key: "double")
  doubleOclType.actualMetatype = Double.self
  let longOclType = createByPKOclType(key: "long")
  longOclType.actualMetatype = Int64.self
  let stringOclType = createByPKOclType(key: "String")
  stringOclType.actualMetatype = String.self
  let sequenceOclType = createByPKOclType(key: "Sequence")
  sequenceOclType.actualMetatype = type(of: [])
  let anyset : Set<AnyHashable> = Set<AnyHashable>()
  let setOclType = createByPKOclType(key: "Set")
  setOclType.actualMetatype = type(of: anyset)
  let mapOclType = createByPKOclType(key: "Map")
  mapOclType.actualMetatype = type(of: [:])
  let voidOclType = createByPKOclType(key: "void")
  voidOclType.actualMetatype = Void.self
	
  let skinCancerOclType = createByPKOclType(key: "SkinCancer")
  skinCancerOclType.actualMetatype = SkinCancer.self

  let skinCancerId = createOclAttribute()
  	  skinCancerId.name = "id"
  	  skinCancerId.type = stringOclType
  	  skinCancerOclType.attributes.append(skinCancerId)
  let skinCancerDates = createOclAttribute()
  	  skinCancerDates.name = "dates"
  	  skinCancerDates.type = stringOclType
  	  skinCancerOclType.attributes.append(skinCancerDates)
  let skinCancerImages = createOclAttribute()
  	  skinCancerImages.name = "images"
  	  skinCancerImages.type = stringOclType
  	  skinCancerOclType.attributes.append(skinCancerImages)
  let skinCancerOutcome = createOclAttribute()
  	  skinCancerOutcome.name = "outcome"
  	  skinCancerOutcome.type = stringOclType
  	  skinCancerOclType.attributes.append(skinCancerOutcome)
}

func instanceFromJSON(typeName: String, json: String) -> AnyObject?
	{ let jdata = json.data(using: .utf8)!
	  let decoder = JSONDecoder()
	  if typeName == "String"
	  { let x = try? decoder.decode(String.self, from: jdata)
	      return x as AnyObject
	  }
if typeName == "SkinCancer"
  { let x = try? decoder.decode(SkinCancer.self, from: jdata) 
  return x
}
  return nil
	}

class ModelFacade : ObservableObject {
		                      
	static var instance : ModelFacade? = nil
	var cdb : FirebaseDB = FirebaseDB.getInstance()
	private var modelParser : ModelParser? = ModelParser(modelFileInfo: ModelFile.modelInfo)
	var fileSystem : FileAccessor = FileAccessor()

	static func getInstance() -> ModelFacade { 
		if instance == nil
	     { instance = ModelFacade() 
	       initialiseOclFile()
	       initialiseOclType() }
	    return instance! }
	                          
	init() { 
		// init
	}
	      
	@Published var currentSkinCancer : SkinCancerVO? = SkinCancerVO.defaultSkinCancerVO()
	@Published var currentSkinCancers : [SkinCancerVO] = [SkinCancerVO]()

		func createSkinCancer(x : SkinCancerVO) {
		    if let obj = getSkinCancerByPK(val: x.id)
			{ cdb.persistSkinCancer(x: obj) }
			else {
			let item : SkinCancer = createByPKSkinCancer(key: x.id)
		      item.id = x.getId()
		      item.dates = x.getDates()
		      item.images = x.getImages()
		      item.outcome = x.getOutcome()
			cdb.persistSkinCancer(x: item)
			}
			currentSkinCancer = x
	}
			
	func cancelCreateSkinCancer() {
		//cancel function
	}
	
	func deleteSkinCancer(id : String) {
		if let obj = getSkinCancerByPK(val: id)
		{ cdb.deleteSkinCancer(x: obj) }
	}
		
	func cancelDeleteSkinCancer() {
		//cancel function
	}
	
	func cancelEditSkinCancer() {
		//cancel function
	}

		func cancelSearchSkinCancer() {
	//cancel function
}

    func imageRecognition(x : String) -> String {
        guard let obj = getSkinCancerByPK(val: x)
        else {
            return "Please selsect valid id"
        }
        
		let dataDecoded = Data(base64Encoded: obj.images, options: .ignoreUnknownCharacters)
		let decodedimage:UIImage = UIImage(data: dataDecoded! as Data)!
        		
    	guard let pixelBuffer = decodedimage.pixelBuffer() else {
        	return "Error"
    	}
    
        // Hands over the pixel buffer to ModelDatahandler to perform inference
        let inferencesResults = modelParser?.runModel(onFrame: pixelBuffer)
        
        // Formats inferences and resturns the results
        guard let firstInference = inferencesResults else {
          return "Error"
        }
        
        obj.outcome = firstInference[0].label
        persistSkinCancer(x: obj)
        
        return firstInference[0].label
        
    }
    
	func cancelImageRecognition() {
		//cancel function
	}
	    


    func listSkinCancer() -> [SkinCancerVO] {
		currentSkinCancers = [SkinCancerVO]()
		let list : [SkinCancer] = SkinCancerAllInstances
		for (_,x) in list.enumerated()
		{ currentSkinCancers.append(SkinCancerVO(x: x)) }
		return currentSkinCancers
	}
			
	func loadSkinCancer() {
		let res : [SkinCancerVO] = listSkinCancer()
		
		for (_,x) in res.enumerated() {
			let obj = createByPKSkinCancer(key: x.id)
	        obj.id = x.getId()
        obj.dates = x.getDates()
        obj.images = x.getImages()
        obj.outcome = x.getOutcome()
			}
		 currentSkinCancer = res.first
		 currentSkinCancers = res
	}
		
	func stringListSkinCancer() -> [String] { 
		var res : [String] = [String]()
		for (_,obj) in currentSkinCancers.enumerated()
		{ res.append(obj.toString()) }
		return res
	}
			
    func searchBySkinCancerid(val : String) -> [SkinCancerVO] {
	    var resultList: [SkinCancerVO] = [SkinCancerVO]()
	    let list : [SkinCancer] = SkinCancerAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.id == val) {
	    		resultList.append(SkinCancerVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchBySkinCancerdates(val : String) -> [SkinCancerVO] {
	    var resultList: [SkinCancerVO] = [SkinCancerVO]()
	    let list : [SkinCancer] = SkinCancerAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.dates == val) {
	    		resultList.append(SkinCancerVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchBySkinCancerimages(val : String) -> [SkinCancerVO] {
	    var resultList: [SkinCancerVO] = [SkinCancerVO]()
	    let list : [SkinCancer] = SkinCancerAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.images == val) {
	    		resultList.append(SkinCancerVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchBySkinCanceroutcome(val : String) -> [SkinCancerVO] {
	    var resultList: [SkinCancerVO] = [SkinCancerVO]()
	    let list : [SkinCancer] = SkinCancerAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.outcome == val) {
	    		resultList.append(SkinCancerVO(x: x))
	    	}
	    }
	  return resultList
	}
	
		
	func getSkinCancerByPK(val: String) -> SkinCancer?
		{ return SkinCancer.skinCancerIndex[val] }
			
	func retrieveSkinCancer(val: String) -> SkinCancer?
			{ return SkinCancer.skinCancerIndex[val] }
			
	func allSkinCancerids() -> [String] {
			var res : [String] = [String]()
			for (_,item) in currentSkinCancers.enumerated()
			{ res.append(item.id + "") }
			return res
	}
			
	func setSelectedSkinCancer(x : SkinCancerVO)
		{ currentSkinCancer = x }
			
	func setSelectedSkinCancer(i : Int) {
		if i < currentSkinCancers.count
		{ currentSkinCancer = currentSkinCancers[i] }
	}
			
	func getSelectedSkinCancer() -> SkinCancerVO?
		{ return currentSkinCancer }
			
	func persistSkinCancer(x : SkinCancer) {
		let vo : SkinCancerVO = SkinCancerVO(x: x)
		cdb.persistSkinCancer(x: x)
		currentSkinCancer = vo
	}
		
	func editSkinCancer(x : SkinCancerVO) {
		if let obj = getSkinCancerByPK(val: x.id) {
		 obj.id = x.getId()
		 obj.dates = x.getDates()
		 obj.images = x.getImages()
		 obj.outcome = x.getOutcome()
		cdb.persistSkinCancer(x: obj)
		}
	    currentSkinCancer = x
	}
			
	}
