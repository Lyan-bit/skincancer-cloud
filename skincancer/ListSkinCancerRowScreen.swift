
import SwiftUI

struct ListSkinCancerRowScreen: View {
    
    var instance : SkinCancerVO
    @ObservedObject var model : ModelFacade = ModelFacade.getInstance()
    @State var image = UIImage()

      var body: some View { 
      	ScrollView {
    HStack  {
          Text(String(instance.id)).bold()
          Text(String(instance.dates))
			Image(uiImage: self.image)
				.resizable()
				.scaledToFit()
				.frame(width: 50, height: 50, alignment: .center)
								                
          Text(String(instance.outcome))
    }.onAppear()
          { model.setSelectedSkinCancer(x: instance) 
            let dataDecoded = Data(base64Encoded: instance.images, options: .ignoreUnknownCharacters)
            guard let decodedimage:UIImage = UIImage(data: dataDecoded! as Data) else { return }
            image = decodedimage
          }
        }
      }
    }

    struct ListSkinCancerRowScreen_Previews: PreviewProvider {
      static var previews: some View {
        ListSkinCancerRowScreen(instance: SkinCancerVO(x: SkinCancerAllInstances[0]))
      }
    }

