
import SwiftUI

struct DeleteSkinCancerScreen: View {
    @State var objectId: String = ""
    @ObservedObject var model : ModelFacade
    
    var body: some View {
  	NavigationView {
  		ScrollView {
      VStack(spacing: 20) {
            HStack (spacing: 20) {
             	Text("id:").bold()
             	Divider()
		        Picker("SkinCancer", selection: $objectId) { 
		        	ForEach(model.currentSkinCancers) { Text($0.id).tag($0.id) }
		        }.pickerStyle(.menu)
		    }.frame(width: 200, height: 30).border(Color.gray)

        HStack(spacing: 20) {
            Button(action: { self.model.deleteSkinCancer(id: objectId) } ) { Text("Delete") }
			Button(action: { self.model.cancelDeleteSkinCancer() } ) { Text("Cancel") }
        }.buttonStyle(.bordered)
      }.padding(.top).onAppear(perform:
        {   objectId = model.currentSkinCancer?.id ?? "id" 
        	model.listSkinCancer()
        })
        }.navigationTitle("Delete SkinCancer")
       }
    } 
}

struct DeleteSkinCancerScreen_Previews: PreviewProvider {
    static var previews: some View {
        DeleteSkinCancerScreen(model: ModelFacade.getInstance())
    }
}

