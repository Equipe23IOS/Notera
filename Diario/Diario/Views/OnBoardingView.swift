//  OnBoardingView.swift
//  Apresentação do App
//  Created by iredefbmac_36

import SwiftUI



struct OnBoardingView: View {
    @AppStorage("hasSeenWelcome") var hasSeenWelcome: Bool = false
        
    
    var body: some View {
        if hasSeenWelcome{
            ContentView()
        }
        else{
            WelcomeView()
        }
        
        
    }
}

#Preview {
    OnBoardingView()
        .onAppear {
                    UserDefaults.standard.set(false, forKey: "hasSeenWelcome")
                }
    
}

let pages = [
    PageInfo(label:"Bem-vindo ao Notera", text:"Um espaço calmo, seguro e só seu. Aqui, você pode escrever tudo o que sente e pensa."),
    PageInfo(label:"Registre seu dia com liberdade", text:"Anote ideias, desabafos, conquistas ou apenas um pensamento solto. Sem regras."),
    PageInfo(label:"Suas anotações são privadas", text:"Tudo o que você escreve no Notera é protegido e acessível a você."),
    PageInfo(label:"Comece sua jornada pessoal", text:"Dê o primeiro passo. Escrever pode transformar seus dias — um momento de cada vez.")
]

struct WelcomeView: View {
    @AppStorage("hasSeenWelcome") var hasSeenWelcome: Bool = false
    var body: some View {
        VStack {
            TabView {
                ForEach(pages) { page in
                    VStack {
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

            Button {
            hasSeenWelcome = true
            } label: {
                Text("Tela inicial")
                    .font(.title3)
                    .fontWeight(.medium)
            }
        }
        .tabViewStyle(.page)
        .onAppear {
            UIPageControl.appearance().currentPageIndicatorTintColor = .label
            UIPageControl.appearance().pageIndicatorTintColor = .systemGray
        }
    }
}

