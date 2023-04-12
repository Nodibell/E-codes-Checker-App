//
//  ContentView.swift
//  E-codes Checker App
//
//  Created by Oleksii Chumak on 22.12.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var eCodeInfo: ECodeInfoModel = ECodeInfoModel()
    @State private var eCode: String = "000"
    @State private var nameECode: String = "Приклад інформації"
    @State private var descriptionECode: String = "Приклад інформації"
    @State private var statusECode: String = "Приклад інформації"
    
    @State private var eCodeTextField: String = ""
    @State private var resultOfFind: String = "Тут зʼявиться загальний результат пошуку"
    @FocusState private var nameIsFocused: Bool
    @State var colorResultOfFind: Color = Color(red: 0.265, green: 0.456, blue: 0.189)
    
    
    var body: some View {
        
        ZStack {
            Image("background").resizable().ignoresSafeArea()
            VStack {
            
                Text("E-Code Checker App").font(.largeTitle).fontWeight(.bold).foregroundColor(Color(red: 0.265, green: 0.456, blue: 0.189)).multilineTextAlignment(.center).padding(.all, 14.0).background(Color(red: 1.0, green: 0.8, blue: 0.006).cornerRadius(10)).padding(.all, 5.0).background(Color(red: 0.999, green: 0.751, blue: 0.017)
                ).cornerRadius(10) // title
                Spacer()
                
                //text to show the info
                VStack{
                    Text("E\(eCode)").font(.title2).fontWeight(.bold).foregroundColor(Color(hue: 0.125, saturation: 1.0, brightness: 1.0)).multilineTextAlignment(.leading).padding(.all, 5.0).background(Color(red: 0.265, green: 0.456, blue: 0.189).cornerRadius(10)).cornerRadius(10).padding(.all, 5.0).background(Color(red: 0.999, green: 0.751, blue: 0.017)
                    ).cornerRadius(10).textSelection(.enabled)

                    Text("Імʼя: \(nameECode)\nОпис: \(descriptionECode)\nСтатус: \(statusECode)").font(.headline).fontWeight(.bold).foregroundColor(Color(red: 0.265, green: 0.456, blue: 0.189)).multilineTextAlignment(.leading)
                }.padding(.all, 14.0).background(Color(red: 1.0, green: 0.8, blue: 0.006).cornerRadius(10)).padding(.all, 5.0).background(Color(red: 0.999, green: 0.751, blue: 0.017)
                ).cornerRadius(10).textSelection(.enabled)
                Spacer()
                
                HStack {
                    Spacer(minLength: 15)
                    HStack { // stack with textField
                        Text("E").font(.largeTitle.bold()).fontWeight(.bold).foregroundColor(Color(hue: 0.125, saturation: 1.0, brightness: 1.0)).multilineTextAlignment(.center).padding(.all, 10.0).frame(width: nil).background(Color(red: 0.265, green: 0.456, blue: 0.189)).cornerRadius(10).padding(.all, 5.0).background(Color(hue: 0.125, saturation: 1.0, brightness: 1.0)
                        ).cornerRadius(10)
                        TextField("Введіть е-код сюди!", text: $eCodeTextField).font(.headline).foregroundColor(Color.black).padding(.all).background(Color.white).cornerRadius(10).padding(.all, 5.0).background(Color(hue: 0.125, saturation: 1.0, brightness: 1.0)
                        ).cornerRadius(10).keyboardType(.default)
                        Spacer()
                    }.padding().background(Color.yellow).cornerRadius(10).padding(.all).padding(.all, -10.0).background(Color(hue: 0.125, saturation: 1.0, brightness: 1.0)
                    ).cornerRadius(10).focused($nameIsFocused)
                    Spacer(minLength: 15)
                    }
                
                VStack {// stack with button
                    Button("Шукати") {
                        guard !eCodeTextField.isEmpty else {
                            print("Entered e-code: nil")
                            resultOfFind = "Введіть значення!"
                            return
                        }
                        nameIsFocused = false
                        print("Entered e-code: \(eCodeTextField).")
                        eCodeInfo = getInfo(by: eCodeTextField)
                        if (eCodeInfo.eCode.isEmpty) {
                            print("There is no info for e-code: E\(eCodeTextField)")
                            eCode = eCodeTextField
                            nameECode = "Інформація відсутня"
                            descriptionECode = "Інформація відсутня"
                            statusECode = "Інформація відсутня"
                            colorResultOfFind = Color(red: 0.992, green: 0.0, blue: 0.0)
                            resultOfFind = "НЕ ЗНАЙДЕНО"
                        } else {
                            eCode = eCodeInfo.eCode
                            nameECode = eCodeInfo.name
                            descriptionECode = eCodeInfo.descriptionColorAndUsage
                            statusECode = eCodeInfo.status
                            print("There is info for e-code: E\(eCodeTextField). Descriprion:\(eCodeInfo.description)")
                            colorResultOfFind = Color(red: 0.265, green: 0.456, blue: 0.189)
                            resultOfFind = "ЗНАЙДЕНО"
                        }
                        eCodeTextField = ""
                    }.font(.largeTitle.bold())
                        //.fontWeight(.bold)
                        .foregroundColor(Color(red: 0.263, green: 0.456, blue: 0.189)).multilineTextAlignment(.center).padding(.all, 14.0).background(Color(red: 1.0, green: 0.8, blue: 0.006).cornerRadius(10)).padding(.all, 5.0).background(Color(red: 0.999, green: 0.751, blue: 0.017)
                    ).cornerRadius(10)
                }
                
                // Show the result of searching in database
                Text(resultOfFind).font(.caption).fontWeight(.heavy).foregroundColor(colorResultOfFind).multilineTextAlignment(.center).padding(.all, 14.0).background(Color(red: 1.0, green: 0.8, blue: 0.006).cornerRadius(10)).padding(.all, 5.0).background(Color(red: 0.999, green: 0.751, blue: 0.017)
                ).cornerRadius(10)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

