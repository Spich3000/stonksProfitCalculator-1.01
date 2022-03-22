//
//  SellPriceView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 22.03.2022.
//

import SwiftUI

struct SellPriceView: View {
    
    @FocusState private var focus: Bool
    
    @State private var quantityOfToken = ""
    @State private var boughtPrice = ""
    @State private var iWantPercentage = ""
    
    var body: some View {
        
        ZStack {
            
            Color.yellow
                .ignoresSafeArea()
            
            VStack {
                
                TextField("Enter quantity of token", text: $quantityOfToken)
                    .textFieldClearButton(text: $quantityOfToken)
                    .title
                    .focused($focus)
                
                TextField("Enter bought price", text: $boughtPrice)
                    .textFieldClearButton(text: $boughtPrice)
                    .title
                    .focused($focus)
                
                TextField("Enter profit you want to receive %", text: $iWantPercentage)
                    .textFieldClearButton(text: $iWantPercentage)
                    .title
                    .focused($focus)
                
                Text("Your bought value:")
                    .foregroundColor(.black)
                    .padding(.bottom, -20)
                
                Text("\(boughtValue, specifier: "%.2f") $")
                    .foregroundColor(.black)
                    .padding()
                
                Text("Set limit order at:")
                    .foregroundColor(.black)
                    .padding(.bottom, -20)
                
                Text("\((sellPrice).formatted()) $")
                    .foregroundColor(.black)
                    .padding()
                
                Text("Your profit:")
                    .foregroundColor(.black)
                    .padding(.bottom, -20)
                
                Text("\(profitValue, specifier: "%.2f") $")
                    .foregroundColor(.black)
                    .padding()
            }
                        
            Button(action: {
                quantityOfToken = ""
                boughtPrice = ""
                iWantPercentage = ""
            }) {
                Text("Clear")
                    .clearButton
            }  .padding(.top, 500.0)
                .shadow(radius: 2)
        }
    }
    
    // Tab#1 calculation
    
    var boughtValue: Double {
        
        let boughtValue = ((Double(convert(text: quantityOfToken)) ?? 0) * (Double(convert(text: boughtPrice)) ?? 0) * 1.001)
        
        return boughtValue
        
    }
    
    var sellPrice: Double {
        
        let sellPrice = ((Double(convert(text: boughtPrice)) ?? 0) * ((1 + (Double(convert(text: iWantPercentage)) ?? 0) / 100) + 0.001))
        
        return sellPrice
    }
    
    var sellValue: Double {
        
        let sellValue = (Double(convert(text: quantityOfToken)) ?? 0) * sellPrice
        
        return sellValue
    }
    
    var profitValue: Double {
        
        let profitValue = sellValue - boughtValue
        
        return profitValue
    }
    
    // Replace "," with "." function
    
    func convert(text: String) -> String {
        text.replacingOccurrences(of: ",", with: ".")
    }
}

struct SellPriceView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            SellPriceView()
        }
    }
}
