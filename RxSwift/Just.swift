//
//  Just.swift
//  RxSwiftSubDemo
//
//  Created by yu on 2017/7/19.
//  Copyright © 2017年 yuxiang. All rights reserved.
//

extension Observable {

    public static func just(_ element: E) -> Observable<E> {
        return Just(element: element)
    }
}


final fileprivate class Just<Element> : Producer<Element> {
    private let _element: Element
    
    init(element: Element) {
        _element = element
    }
    
    override func subscribe<O : ObserverType>(_ observer: O) -> Void where O.E == Element {
        observer.on(.next(_element))
        observer.on(.completed)
    }
}

