# SwiftUILoader
Custom Loader For SwiftUI | SwiftUI Loader | Activity Indicator SwiftUI

How to use it:

    import SwiftUI
    
    struct ExampleView: View {
    
        @State var isLoading: Bool = false
    
        var body: some View {
           CustomCircleLoader(isShowing: $isLoading)
              VStack {
                //Your Code
              }
          }
        }
    }

  
![ezgif com-video-to-gif](https://github.com/AakifNadeem/SwiftUILoader/assets/58801997/8a41666f-a6f9-4b40-a64d-9a0ea9725836)
