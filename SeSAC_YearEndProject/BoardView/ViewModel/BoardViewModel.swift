//
//  BoardViewModel.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/04.
//

import Foundation
import RxRelay
import UIKit

class BoardViewModel {
    var list = BehaviorRelay<Bearers>(value: Bearers())
    
    func bearerList(completion: @escaping () -> Void) {
        
        APIService.boards { bearer, error in
            // userData가 옵셔널 타입이기 때문에 옵셔널 해제를 해줘야함
            guard let bearer = bearer else {
                print(error?.rawValue ?? "모름")
                completion()
                return
            }
            
            self.list.accept(bearer)
            completion()
        }
    }
}
