//
//  ObserverType.swift
//  RxSwiftSubDemo
//
//  Created by yu on 2017/7/19.
//  Copyright © 2017年 yuxiang. All rights reserved.
//

public protocol ObserverType {
    
    associatedtype E
    
    func on(_ event: Event<E>)
}


extension ObserverType {
    

    public final func onNext(_ element: E) {
        on(.next(element))
    }
    
    public final func onCompleted() {
        on(.completed)
    }

    public final func onError(_ error: Swift.Error) {
        on(.error(error))
    }
}

