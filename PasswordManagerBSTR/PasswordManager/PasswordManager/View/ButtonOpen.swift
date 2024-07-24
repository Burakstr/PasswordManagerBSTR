//
//  ButtonOpen.swift
//  PasswordManager
//
//  Created by Ataberk Özkar on 11.07.2024.
//

import SwiftUI

struct ButtonOpen: View {
    var body: some View {
        ZStack{
            VStack(spacing: 16) {
                Button(action: {
                }) {
                    Text("Social Media")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 4)
                        .foregroundColor(.black)
                }
                
                Button(action: {
                }) {
                    Text("Mobile Bank Account")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 4)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 32)
            
            Spacer()
                .frame(height: 32)
        }
        .background(Color(UIColor.systemGray6))
    }
}


#Preview {
    ButtonOpen()
}
