// !!!tutorial from: A Swiftly Tilting Planet(Youtube)
//  OnBoardingView.swift
//  Apresentação do App
//  Created by iredefbmac_36 on 06/06/25.

import SwiftUI

struct OnBoardingView: View {
    @AppStorage("isWelcomeSheetShowing") var isWelcomeSheetShowing = true
    
    var body: some View {
        VStack{
            
        }
        
        .sheet(isPresented: $isWelcomeSheetShowing) {
            WelcomeView(isWelcomeSheetShowing: $isWelcomeSheetShowing)
        }
    }
}

#Preview {
    //OnBoardingView()
    WelcomeView(isWelcomeSheetShowing: .constant(true))
}

let pages = [
    PageInfo(label:"Bem-vindo ao Notera", text:"Um espaço calmo, seguro e só seu. Aqui, você pode escrever tudo o que sente e pensa."),
    PageInfo(label:"Registre seu dia com liberdade", text:"Anote ideias, desabafos, conquistas ou apenas um pensamento solto. Sem regras."),
    PageInfo(label:"Suas anotações são privadas", text:"Tudo o que você escreve no Notera é protegido e acessível a você."),
    PageInfo(label:"Comece sua jornada pessoal", text:"Dê o primeiro passo. Escrever pode transformar seus dias — um momento de cada vez.")
]

struct WelcomeView: View {
    @Binding var isWelcomeSheetShowing: Bool
    var body: some View{
        VStack{
            TabView{
                ForEach(pages) { page in
                    VStack{
                        Text(page.label)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            
                        Text(page.text)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }
            }
            
            Button{
                isWelcomeSheetShowing.toggle()
            } label: {
                Text("Pular introdução")
                    .font(.title3)
                    .fontWeight(.medium)
            }
            
            
        }
            .interactiveDismissDisabled()
            .tabViewStyle(.page)
            .onAppear{
                UIPageControl.appearance().currentPageIndicatorTintColor = .label
                UIPageControl.appearance().pageIndicatorTintColor = .systemGray
            }
    }
}
