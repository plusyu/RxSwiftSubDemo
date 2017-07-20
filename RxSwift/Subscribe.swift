//
//  subscribe.swift
//  RxSwiftSubDemo
//
//  Created by yu on 2017/7/19.
//  Copyright © 2017年 yuxiang. All rights reserved.
//


extension ObservableType {
    
    public func subscribe(_ on: @escaping (Event<Self.E>) -> Void) -> Void {
      
        let observer = AnonymousObserver { e in
            on(e)
        }
        return self.subscribeSafe(observer)
    }
}

extension ObservableType {
    
    fileprivate func subscribeSafe<O: ObserverType>(_ observer: O) -> Void where O.E == E {
        return self.asObservable().subscribe(observer)
    }
}

