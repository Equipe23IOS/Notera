//
//  HumorTrackerViewModel.swift
//  Diario
//
//  Created by iredefbmac_36 on 09/08/25.
//

import SwiftUI

class HumorTrackerViewModel: ObservableObject {
    let database = DataSource.shared
    @Published var trackedDays: [DayModel] = []
    
    init(trackedDays: [DayModel]) {
        self.trackedDays = database.fetchDays()
    }
    
    //Criar um novo dia com data, sprite e memo
    func createDay(_ day: Date, _ selectedSprite: String, _ memo: String) {
        //Regra: cria o modelo do dia com data, sprite e memo informados
        let day = DayModel(day: day, emojiSprite: selectedSprite, memo: memo)
        //Regra: salva o dia no banco de dados
        database.appendDay(day: day)
        //Regra: adiciona o dia na lista de dias rastreados
        trackedDays.append(day)
        print(day.memo)
    }

    //Excluir um dia existente
    func deleteDay(_ day: DayModel) {
        //Regra: remove o dia do banco de dados
        database.deleteDay(day: day)
        //Regra: remove o dia da lista de dias rastreados
        trackedDays.removeAll(where: { $0.id == day.id })
    }

    //Atualizar informações de um dia já registrado
    func updateDay(_ day: DayModel, _ selectedSprite: String, _ memo: String) {
        //Regra: só atualiza se o dia existir na lista
        guard let index = trackedDays.firstIndex(where: { $0.id == day.id }) else {
            return
        }
        
        //Regra: se memo estiver vazio, mantém o anterior
        trackedDays[index].memo = memo == "" ? trackedDays[index].memo : memo
        //Regra: se sprite estiver vazio, mantém o anterior
        trackedDays[index].emojiSprite = selectedSprite == "" ? trackedDays[index].emojiSprite : selectedSprite
        //Regra: atualiza a lista de dias rastreados
        trackedDays = trackedDays
        //Regra: atualiza o dia no banco de dados
        database.updateDay(day: trackedDays[index], updatedDay: day)
    }

    //Buscar um dia específico pela data
    func getDay(_ day: Date) -> DayModel? {
        //Regra: compara apenas ano, mês e dia (ignora hora)
        let componentDay = Calendar.current.dateComponents([.year, .month, .day], from: day)
        guard let componentizedDay = trackedDays.filter({ Calendar.current.dateComponents([.year, .month, .day], from: $0.day) == componentDay}).first else {
            return nil
        }
        //Regra: retorna o dia encontrado ou nil se não existir
        return componentizedDay
    }

    //Gerar estatísticas de quantidade de dias por tipo de humor
    func getInfo() -> [(name: String, amount: Int)] {
       var amountOfVerySad: Int = 0
       var amountOfSad: Int = 0
       var amountOfNeutral: Int = 0
       var amountOfHappy: Int = 0
       var amountOfVeryHappy: Int = 0
       
       //Regra: percorre todos os dias rastreados e conta cada tipo
       for i in trackedDays {
           switch i.emojiSprite {
           case "SaddestEmoji":
               amountOfVerySad += 1
           case "SadEmoji":
               amountOfSad += 1
           case "NeutralEmoji":
               amountOfNeutral += 1
           case "HappyEmoji":
               amountOfHappy += 1
           case "HappiestEmoji":
               amountOfVeryHappy += 1
           default:
               print("nothing")
           }
       }
       
       //Regra: retorna um resumo com nome e quantidade de cada tipo
       return [
        ("Very Sad", amountOfVerySad),
        ("Sad", amountOfSad),
        ("Neutral", amountOfNeutral),
        ("Happy", amountOfHappy),
        ("Very Happy", amountOfVeryHappy)
       ]
    }
}
