              
              
              
import SwiftUI

struct ContentView : View {
	
	@ObservedObject var model : ModelFacade
	                                       
	var body: some View {
		TabView {
            CreateSkinCancerScreen (model: model).tabItem { 
                        Image(systemName: "1.square.fill")
	                    Text("+SkinCancer")} 
            ListSkinCancerScreen (model: model).tabItem { 
                        Image(systemName: "2.square.fill")
	                    Text("ListSkinCancer")} 
            EditSkinCancerScreen (model: model).tabItem { 
                        Image(systemName: "3.square.fill")
	                    Text("EditSkinCancer")} 
            DeleteSkinCancerScreen (model: model).tabItem { 
                        Image(systemName: "4.square.fill")
	                    Text("-SkinCancer")} 
            SearchSkinCancerdatesScreen (model: model).tabItem { 
                        Image(systemName: "5.square.fill")
	                    Text("SearchSkinCancerdates")} 
            ImageRecognitionScreen (model: model).tabItem { 
                        Image(systemName: "6.square.fill")
	                    Text("ImageRecognition")} 
				}.font(.headline)
		}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: ModelFacade.getInstance())
    }
}

