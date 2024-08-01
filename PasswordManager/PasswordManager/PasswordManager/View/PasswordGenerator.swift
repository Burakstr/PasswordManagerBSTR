//
//  PasswordGenerator.swift
//  PasswordGenerator
//
//  Created by Burak Satır on 24.07.2024.
//

import SwiftUI

struct PasswordGenerator: View {
    @ObservedObject var viewModel = PasswordGeneratorViewModel()
    @State private var showCopiedMessage = false

    var body: some View {
        ZStack {
            Color(hex: "#0C1E34")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Generate Password")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("GENERATED PASSWORD")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(hex: "#8E9CA9"))
                    
                    ZStack(alignment: .bottomTrailing) {
                        Text(viewModel.password)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 100)
                            .background(Color(hex: "#1F2C44"))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(hex: "#1F2C44"), lineWidth: 2)
                            )
                            .contextMenu {
                                Button(action: {
                                    viewModel.copyToClipboard()
                                }) {
                                    Text("Copy to clipboard")
                                    Image(systemName: "doc.on.doc")
                                }
                            }
                        
                        HStack {
                            Button(action: {
                                viewModel.copyToClipboard()
                                withAnimation {
                                    showCopiedMessage = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation {
                                        showCopiedMessage = false
                                    }
                                }
                            }) {
                                Image(systemName: "doc.on.doc")
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color.white.opacity(0))
                                    .cornerRadius(8)
                            }
                            
                            Button(action: {
                                viewModel.sharePassword()
                            }) {
                                Image(systemName: "square.and.arrow.up")
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color.white.opacity(0))
                                    .cornerRadius(8)
                            }
                        }
                        
                    }
                    
                    if showCopiedMessage {
                        Text("Copied to clipboard")
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: "#8E9CA9"))
                            .transition(.opacity)
                    }
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Length: \(Int(viewModel.length))")
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: "#8E9CA9"))
                        .padding(.leading,16)
                    HStack {
                        Text("4")
                            .foregroundColor(.white)
                        Slider(value: $viewModel.length, in: 4...32, step: 1)
                            .accentColor(Color(hex: "#027AFF"))
                            .padding(4)
                        Text("32")
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                    .background(Color(hex: "#1F2C44"))
                    .cornerRadius(8)
                    .padding(.horizontal)

                }
                .padding(.vertical, 10)

                VStack(alignment: .leading, spacing: 10) {
                    Toggle(isOn: $viewModel.includeLowercase) {
                        Text("Include lowercase letters")
                            .foregroundColor(.white)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: Color(.blue)))
                    .padding(.horizontal,8)
                    .padding(.vertical,8)
                    .background(Color(hex: "#1F2C44"))
                    .cornerRadius(8)
                    .fontWeight(.regular)
                    
                    Toggle(isOn: $viewModel.includeUppercase) {
                        Text("Include uppercase letters")
                            .foregroundColor(.white)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: Color(.blue)))
                    .padding(.horizontal,8)
                    .padding(.vertical,8)
                    .background(Color(hex: "#1F2C44"))
                    .cornerRadius(8)
                    .fontWeight(.regular)

                    Toggle(isOn: $viewModel.includeNumbers) {
                        Text("Include numbers")
                            .foregroundColor(.white)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: Color(.blue)))
                    .padding(.horizontal,8)
                    .padding(.vertical,8)
                    .background(Color(hex: "#1F2C44"))
                    .cornerRadius(8)
                    .fontWeight(.regular)

                    Toggle(isOn: $viewModel.includeSymbols) {
                        Text("Include symbols")
                            .foregroundColor(.white)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: Color(.blue)))
                    .padding(.horizontal,8)
                    .padding(.vertical,8)
                    .background(Color(hex: "#1F2C44"))
                    .cornerRadius(8)
                    .fontWeight(.regular)

                }
                .padding(.horizontal)
                .padding(.top, 10)

                Button(action: {
                    viewModel.generatePassword()
                }) {
                    Text("GENERATE PASSWORD")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .cornerRadius(8)
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
                Spacer()
            }
            .padding(.top)
        }
        .animation(.default, value: showCopiedMessage)
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}

#Preview {
    PasswordGenerator()
}
