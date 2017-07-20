//
//  ObservableType.swift
//  RxSwiftSubDemo
//
//  Created by yu on 2017/7/19.
//  Copyright © 2017年 yuxiang. All rights reserved.
//

public protocol ObservableType : ObservableConvertibleType {
    
    associatedtype E
    

    func subscribe<O: ObserverType>(_ observer: O) -> Void where O.E == E
}

extension ObservableType {
    
    public func asObservable() -> Observable<E> {
        return Observable.create { o in
            return self.subscribe(o)
        }
    }
}
