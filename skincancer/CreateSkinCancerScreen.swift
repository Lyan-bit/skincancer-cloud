
import SwiftUI

struct CreateSkinCancerScreen: View {
 
  @State var bean : SkinCancerVO = SkinCancerVO()
  @ObservedObject var model : ModelFacade

  @State var showSheet = false
  @State var image = UIImage()
  @State var sourceType:
  UIImagePickerController.SourceType = .photoLibrary
  
  var body: some View {
  	NavigationView {
  		ScrollView {
  	VStack(spacing: 20) {

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


      HStack(spacing: 20) {
        Button(action: { 
        	let img : UIImage = image
        if img.pngData() != nil {
        	let imageData:NSData = img.pngData()! as NSData
        	let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        	bean.images = strBase64 
        } else { bean.images = ""}
        	self.model.createSkinCancer(x: bean)
        } ) { Text("Create") }
        Button(action: { self.model.cancelCreateSkinCancer() } ) { Text("Cancel") }
      }.buttonStyle(.bordered)
    }.padding(.top).sheet(isPresented: $showSheet) {
    	ImagePicker(sourceType: sourceType, chosenImage: $image)
    }
     }.navigationTitle("Create SkinCancer")
    }
  }
}

struct CreateSkinCancerScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateSkinCancerScreen(model: ModelFacade.getInstance())
    }
}

