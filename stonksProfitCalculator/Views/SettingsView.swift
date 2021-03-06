//
//  SettingsView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 22.03.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var showingAlert = false
    
    @State private var pick: Int = 0
    
    @ObservedObject var commission: CommissionRate
    
    let commissions = [0, 0.00075, 0.001, 0.002, 0.005]
    
    @AppStorage("isDarkMode") private var isDarkMode = false
        
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("backgroundWhite"), Color("backgroundGray")]),
                startPoint: UnitPoint(x: 0.2, y: 0.2),
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack(spacing: 25) {
                    // About
                    Text("About:")
                        .font(.largeTitle)
                        .underline()
                        .text
                    Text("This is app for my crypto-blog in Telegram. Stay tuned for new features!")
                        .lineSpacing(10)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal,20)
                        .text
                    // Telegram redirect
                    Link(destination: URL(string: "https://t.me/stonks_signals")!, label: {
                        HStack {
                            Text("Telegram:")
                            Image(systemName: "paperplane")
                        }
                    })
                    .buttonStyle(SimpleButtonStyle())
                } //VStack About
                
                VStack(spacing: 15) {
                    // Donate with alert
                    Text("Feel free for donate:")
                        .text
                    // DonationAlerts redirect
                    Link(destination: URL(string: "https://www.donationalerts.com/r/spich59")!, label: {
                        HStack {
                            Text("Donate")
                        }
                    })
                    .buttonStyle(SimpleButtonStyle())
                } //VStack Donate
                
                VStack {
                    Text("Select exchange commission rate:")
                        .text
                    Picker(selection: $pick, label: Text("Commission picker"), content: {
                        Text("0%").tag(0)
                        Text("0.075%").tag(1)
                        Text("0.1%").tag(2)
                        Text("0.2%").tag(3)
                        Text("0.5%").tag(4)
                    })
                        .pickerModifier
                        .padding(.horizontal,20)
                        .onAppear {
                            PickerViewModifier()
                        }
                        .onChange(of: pick) { newValue in
                            commission.commission = Double(commissions[pick])
                        }
                } //VStack select commission
                
                VStack {
                    Text("Color scheme:")
                        .text
                    Picker(selection: $isDarkMode, label: Text("Dark mode"), content: {
                        Text("Light").tag(false)
                        Text("Dark").tag(true)
                    })
                        .pickerModifier
                        .padding(.horizontal,20)
                        .onAppear {
                            PickerViewModifier()
                        }
                } //VStack select DarkMode
            }
        } .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            SettingsView(commission: CommissionRate())
        }
    }
}

