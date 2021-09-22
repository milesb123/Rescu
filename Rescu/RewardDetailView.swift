//
//  RewardDetailView.swift
//  Rescu
//
//  Created by Miles Broomfield on 22/09/2021.
//

import SwiftUI

struct RewardDetailView: View {
    
    let reward:Reward
    let status:RewardStatus
    
    var body: some View {
        VStack(spacing:0){
            Rectangle()
                .foregroundColor(Color("mainGreen"))
                .frame(height:1)
            ScrollView{
                VStack(spacing:20){
                    VStack(spacing:20){
                        RewardDetailInfo(reward: reward,padding:10)
                        Text(reward.info)
                            .padding(.horizontal,10)
                    }
                    .padding(.top,self.status == .redeemed ? 0 : 30)
                    .padding(.bottom,30)
                    .background(status == .redeemed ? nil : Color("mainGreen").edgesIgnoringSafeArea(.top))
                    VStack{
                        if(status == .redeemed){
                            primaryButton(text: "View Live Reward", action: {}, capsuleColor: .white, textColor: .black)
                        }
                        else if(status == .purchase){
                            primaryButton(text: "Purchase", action: {}, capsuleColor: Color("mainGreen"), textColor: .white)
                        }
                        else if (status == .redeem){
                            primaryButton(text: "Redeem 🥳", action: {},description: "Tired of waiting the long queue at Guy’s Bar? Redeem this queue skip by presenting the QR code at the door.", capsuleColor: Color("mainGreen"), textColor: .white)
                        }
                    }
                    .padding(.vertical,self.status == .redeemed ? 30 : nil)
                    .background(self.status == .redeemed ? Color("mainGreen") : nil)
                    
                    Spacer()
                }
                .padding(.top, 20)
            }
        }
        .foregroundColor(status == .redeemed ? .black : .white)
        .navigationBarTitle("Reward", displayMode: .inline)
    }
    
    func primaryButton(text:String,action:@escaping ()->Void,description:String? = nil,capsuleColor:Color,textColor:Color) -> some View{
        return
        VStack(spacing:20){
            Button(action:{action()}){
                HStack{
                    Spacer()
                    Text(text)
                        .bold()
                    Spacer()
                }
                .padding(15)
                .background(Capsule().foregroundColor(capsuleColor))
                .padding(.horizontal,10)
            }
            if(description != nil){
                Text(description!)
                    .foregroundColor(.black)
                    .padding(.horizontal,10)
                    .font(.subheadline)
            }
        }
    }
    
    
    struct RewardDetailInfo: View{
        
        let reward:Reward
        let padding:CGFloat
        
        var body : some View{
            HStack(alignment:.top,spacing:20){
                Image(reward.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width:100,height:100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment:.leading,spacing:10){
                    Text(reward.title)
                        .font(.headline)
                        .bold()
                    HStack{
                        Text("\(reward.cost)")
                            .font(.headline)
                            .fontWeight(.regular)
                        Image("coin")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height:20)
                        Spacer()
                    }
                }
            }
            .padding(.horizontal,padding)
            .frame(height:100)
        }
    }
    
    enum RewardStatus{
        case purchase
        case redeem
        case redeemed
    }
}

struct RewardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RewardDetailView(reward: .init(id: "1", title: "Guy's Bar Queue Skip", info: "Tired of waiting the long queue at Guy’s Bar? Redeem this queue skip by presenting the QR code at the door.", cost: 240, image: "guy's bar"), status: .redeemed)
    }
}
