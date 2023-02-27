
import SwiftUI

struct EditSkinCancerScreen: View {
    @State var objectId: String = ""
    @ObservedObject var model : ModelFacade
    @State var bean : SkinCancer = SkinCancer()
    
    @State var showSheet = false
    @State var image = UIImage()
    @State var sourceType:
    UIImagePickerController.SourceType = .photoLibrary
  
    var body: some View {
  	NavigationView {
  		ScrollView {
      VStack(spacing: 20) {
      	HStack (spacing: 20) {
      	Text("id:")
      	Divider()
        Picker("SkinCancer", selection: $objectId) { 
        	ForEach(model.currentSkinCancers) { Text($0.id).tag($0.id) }
        }.pickerStyle(.menu)
        }.frame(width: 200, height: 30).border(Color.gray)
		      HStack (spacing: 20) {
		        Text("Id:").bold()
		        TextField("Id", text: $bean.id).textFieldStyle(RoundedBorderTextFieldStyle())
		      }.frame(width: 200, height: 30).border(Color.gray)

		      HStack (spacing: 20) {
		        Text("Dates:").bold()
		        TextField("Dates", text: $bean.dates).textFieldStyle(RoundedBorderTextFieldStyle())
		      }.frame(width: 200, height: 30).border(Color.gray)

    Image(uiImage: self.image)
		.resizable()
		.scaledToFit()
		.frame(width: 150, height: 150, alignment: .center)
						                
	HStack (spacing: 20) {
		 Button("Pick Photo") {
		   showSheet = true
		   sourceType = .photoLibrary
		 }
		                                    
		 Button("Take Photo"){
		    showSheet = true
		    sourceType = .camera
		 }
    }.buttonStyle(.bordered)
						                
		      HStack (spacing: 20) {
		        Text("Outcome:").bold()
		        TextField("Outcome", text: $bean.outcome).textFieldStyle(RoundedBorderTextFieldStyle())
		      }.frame(width: 200, height: 30).border(Color.gray)


HStack (spacing: 20) {
		Button(action: { 
	bean = model.getSkinCancerByPK(val: objectId) ?? bean
			let dataDecoded = Data(base64Encoded: bean.images, options: .ignoreUnknownCharacters)
			guard let decodedimage:UIImage = UIImage(data: dataDecoded! as Data) else { return }
			image = decodedimage
		} ) { Text("Search") }
        Button(action: { 
        	let img : UIImage = image
        if img.pngData() != nil {
        	let imageData:NSData = img.pngData()! as NSData
        	let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        	bean.images = strBase64 
        } else { bean.images = ""}
        	self.model.editSkinCancer(x: SkinCancerVO(x: bean))
        } ) { Text("Edit") }
        Button(action: { self.model.cancelEditSkinCancer() } ) { Text("Cancel") }
      }.buttonStyle(.bordered)
    }.padding(.top).sheet(isPresented: $showSheet) {
    	ImagePicker(sourceType: sourceType, chosenImage: $image)
    }
    .onAppear(perform:
            {   objectId = model.currentSkinCancer?.id ?? "id" 
            	model.listSkinCancer()
            })
    	}.navigationTitle("Edit SkinCancer")
     }
  }
}

struct EditSkinCancerScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditSkinCancerScreen(model: ModelFacade.getInstance())
    }
}
