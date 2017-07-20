//
//  Producer.swift
//  RxSwiftSubDemo
//
//  Created by yu on 2017/7/19.
//  Copyright © 2017年 yuxiang. All rights reserved.
//

class Producer<Element> : Observable<Element> {
    override init() {
        super.init()
    }
    
    override func subscribe<O : ObserverType>(_ observer: O) -> Void where O.E == Element {
            run(observer)
    }
    
    func run<O : ObserverType>(_ observer: O) ->  Void where O.E == Element {
        
    }
}


