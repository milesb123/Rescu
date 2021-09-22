//
//  ProfileView.swift
//  Rescu
//
//  Created by Miles Broomfield on 22/09/2021.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(alignment:.leading,spacing:30){
            VStack(alignment:.leading,spacing:10){
                Text("Miles Broomfield")
                    .font(.title)
                    .bold()
                Text("Computer Science")
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal,10)
            
            VStack(alignment:.leading,spacing:10){
                Text("You have made")
                    .font(.headline)
                    .fontWeight(.regular)
                Text("89")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                Text("Deposits 🥳")
                    .font(.headline)
                    .fontWeight(.regular)
                HStack{
                    Spacer()
                }

            }
            .padding(.horizontal,10)
            .padding(.vertical,30)
            .foregroundColor(.white)
            .background(Color("mainGreen"))
            
            NavigationLink(
                destination: WalletView(),
                label: {
                VStack(alignment:.leading,spacing:20){
                    HStack{
                        Text("Wallet")
                            .font(.headline)
                            .bold()
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height:20)
                            .foregroundColor(Color("mainGreen"))
                            .padding(.trailing,10)
                    }
                    .padding(.horizontal,10)

                    Rectangle()
                        .foregroundColor(Color("mainGreen"))
                        .frame(height:1)
                        .padding(.trailing,20)

                }
            })
            
            Spacer()
        }
        .padding(.top,20)
        .navigationBarHidden(true)
    }
}

struct WalletView:View{
    var body : some View{
        VStack{
            Rectangle()
                .foregroundColor(Color("mainGreen"))
                .frame(height:1)
            Spacer()
        }
        .navigationBarTitle("Wallet", displayMode: .inline)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
