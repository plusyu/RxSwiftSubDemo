//
//  ObserverBase.swift
//  RxSwiftSubDemo
//
//  Created by yu on 2017/7/19.
//  Copyright © 2017年 yuxiang. All rights reserved.
//

class ObserverBase<ElementType> : ObserverType {
    typealias E = ElementType
    
    private var _isStopped = 0
    
    func on(_ event: Event<E>) {
        switch event {
        case .next:
            if _isStopped == 0 {
                onCore(event)
            }
        case .error, .completed: break
          
        }
    }
    
    func onCore(_ event: Event<E>) {
        
    }
    
    func dispose() {
        
    }
}
