//
//  StoreView.swift
//  Rescu
//
//  Created by Miles Broomfield on 13/09/2021.
//

import SwiftUI

struct StoreView: View {
    
    @State var searchText:String = ""
    @State var rewards:[Reward] = [Reward(id: UUID().description, title: "Guy's Bar Queue Skip", info: "Tired of waiting the long queue at Guy’s Bar? Redeem this queue skip by presenting the QR code at the door.", cost: 100, image: "guy's bar"),Reward(id:UUID().description,title:"1 Healthy Free School Meal",info:"",cost:25,image:"jamie"),Reward(id: UUID().description, title: "1 Coffee from Strand Cafe", info: "", cost: 250, image: "coffee")]
    
    var body: some View {
        VStack(spacing:0){
            VStack(spacing:20){
                VStack(alignment:.leading){
                    HStack(spacing:10){
                        Image(systemName: "cart.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height:20)
                        Text("Store")
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                }
                .padding(10)
                .foregroundColor(.white)
                .background(
                    ColorScheme.mainColor.edgesIgnoringSafeArea(.top)
                )
                
                SearchBar(padding: 10, searchText: $searchText)
                
                Rectangle()
                    .foregroundColor(ColorScheme.mainColor)
                    .opacity(0.5)
                    .frame(height:0.5)
            }
            ScrollView{
                VStack(spacing:20){
                    ForEach(self.rewards.filter({reward in self.filterCondition(reward:reward)}).sorted(by: {$0.title > $1.title}), id: \.id){reward in
                        StoreRow(reward: reward, padding: 10)
                    }
                }
                .padding(.top,20)
            }
        }
        .navigationBarHidden(true)
    }
    
    func filterCondition(reward:Reward) -> Bool{
        if(self.searchText.isEmpty){
            return true
        }
        else{
            return reward.title.contains(self.searchText) || reward.info.contains(self.searchText)
        }
    }

    
    struct StoreRow:View{
        
        let reward:Reward
        let padding:CGFloat
        
        var body : some View{
            NavigationLink(
                destination: RewardDetailView(reward: reward, status: .redeemed),
                label: {
                
                VStack(alignment:.leading,spacing:20){
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
                            Spacer()
                            HStack{
                                Spacer()
                                Text("\(reward.cost)")
                                    .font(.headline)
                                    .fontWeight(.regular)
                                Image("coin")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height:20)
                            }
                        }
                    }
                    .padding(.horizontal,padding)
                    .frame(height:100)
                    Rectangle()
                        .foregroundColor(ColorScheme.mainColor)
                        .opacity(0.5)
                        .frame(height:0.5)
                        .padding(.trailing,padding)
                }
                .foregroundColor(.black)
            })
        }
    }
    
    struct SearchBar:View{
        
        let padding:CGFloat
        @Binding var searchText:String
        
        var body : some View{
            ZStack{
                Capsule()
                    .stroke(lineWidth: 2)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .frame(height:40)
                HStack{
                    TextField("Search Here", text: $searchText)
                        .foregroundColor(.black)
                        .accentColor(ColorScheme.mainColor)
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(ColorScheme.mainColor)
                        .frame(height:20)
                    
                }
                .padding(.horizontal,2*padding)
            }
            .foregroundColor(ColorScheme.mainColor)
            .padding(.horizontal,padding)
        }
        
    }
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView()
    }
}
