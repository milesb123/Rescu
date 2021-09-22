//
//  MotherView.swift
//  Rescu
//
//  Created by Miles Broomfield on 13/09/2021.
//

import SwiftUI

class ColorScheme{
    static let mainColor = Color("mainGreen")
}

enum MainView{
    case barcode
    case store
    case profile
}

extension UIDevice {
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            if UIApplication.shared.windows.count == 0 { return false } // Should never occur, but…
            let top = UIApplication.shared.windows[0].safeAreaInsets.top
            return top > 20 // That seem to be the minimum top when no notch…
        }
        else{
            // Fallback on earlier versions
            return false
        }
    }
}

struct MotherView: View {
    
    @State var viewShown:MainView = .barcode
    
    init(){
        self.navigationInit(color: .black)
    }
    
    var body: some View {
        VStack(spacing:0){
            if(viewShown == .barcode){
                Text("Barcode")
                Spacer()
            }
            if(viewShown == .store){
                NavigationView{
                    StoreView()
                }
            }
            if(viewShown == .profile){
                NavigationView{
                    ProfileView()
                }
            }
            NavigationBar(viewShown: $viewShown)
        }
    }
    
    func navigationInit(color:UIColor){
        // this is not the same as manipulating the proxy directly
        let appearance = UINavigationBarAppearance()
        
        // this overrides everything you have set up earlier.
        appearance.configureWithTransparentBackground()
        
        // this only applies to big titles
                
        appearance.largeTitleTextAttributes = [
            .font : UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor : color
        ]
        // this only applies to small titles
        appearance.titleTextAttributes = [
            .font : UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor : color
        ]
        
        //In the following two lines you make sure that you apply the style for good
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        
        // This property is not present on the UINavigationBarAppearance
        // object for some reason and you have to leave it til the end
        UINavigationBar.appearance().tintColor = color
    }
}

struct NavigationBar:View{
    
    @Binding var viewShown:MainView
    
    var body : some View{
        VStack(spacing:0){
            Rectangle()
                .foregroundColor(ColorScheme.mainColor)
                .frame(height:1)
            HStack(spacing:30){
                Spacer()
                navButton(viewID: .store, icon: "cart.fill", viewShown: self.viewShown)
                Spacer()
                navButton(viewID: .barcode, icon: "camera.fill", viewShown: self.viewShown)
                Spacer()
                navButton(viewID: .profile, icon: "person.crop.circle.fill", viewShown: self.viewShown)
                Spacer()
            }
            .padding([.top,.horizontal],10)
            .padding(.bottom,UIDevice.current.hasNotch ? 0 : 20)
        }
    }
    
    func navButton(viewID:MainView,icon:String,viewShown:MainView) -> some View{
        return
            Button(action:{self.viewShown = viewID}){
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height:20)
                    .foregroundColor(ColorScheme.mainColor)
                    .opacity((viewID == viewShown) ? 1 : 0.6)
        }
    }
    
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView()
    }
}
