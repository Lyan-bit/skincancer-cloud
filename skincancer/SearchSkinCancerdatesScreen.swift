
import SwiftUI

struct SearchSkinCancerdatesScreen: View {
    @State var dates:  String = "" 
    @ObservedObject var model : ModelFacade
    @State var bean : [SkinCancerVO] = [SkinCancerVO] ()
    
    var body: some View {
  	NavigationView { 
      VStack(alignment: HorizontalAlignment.center, spacing: 20) {
      	 Spacer()
      	
		 HStack (spacing: 20) {
		  	Text("dates:").bold()
		  	Divider()
	        Picker("SkinCancer", selection: $dates) { 
	        	ForEach(model.currentSkinCancers) { Text($0.dates).tag($0.dates) }
	        }.pickerStyle(.menu)
	 	 }.frame(width: 200, height: 30).border(Color.gray)
       
		HStack(spacing: 20) {
	        Button(action: { bean = self.model.searchBySkinCancerdates(val: dates) } ) { Text("Search") }
	        Button(action: { self.model.cancelSearchSkinCancer() } ) { Text("Cancel") }
	      }.buttonStyle(.bordered)
    
		List(bean) { instance in 
			ListSkinCancerRowScreen(instance: instance) }
		    
		Spacer()
	
    }.onAppear(perform:
    	{   dates = model.currentSkinCancer?.dates ?? dates 
    		model.listSkinCancer()
    	})
     .navigationTitle("Search by dates")
    }
  }
}

struct SearchSkinCancerdatesScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchSkinCancerdatesScreen(model: ModelFacade.getInstance())
    }
}
