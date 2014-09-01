//
//  FunCalc.swift
//  FunCalc
//
//  Created by Bryan Harrell on 18/08/2014.
//  Copyright (c) 2014 Bryan Harrell. All rights reserved.
//

import Foundation
// 1
class FunCalcModel {
    // 2
    var total: Double
    var calcTotal: Float
    var taxPct: Double
    var subtotal: Double {
        get {
            return total / (taxPct + 1)
        }
        set(newSubtotal) {
            //...
        }
    }
    init(total:Double, taxPct:Double, calcTotal: Float) {
        self.total = total
        self.taxPct = taxPct
        self.calcTotal = calcTotal
        
        
    }
    // 4
    
    
    func calcTipWithTipPct(tipPct:Double) -> Double {
        return subtotal * tipPct
    }
    // 1
    func getCalc () -> Float{
        return calcTotal;
    }
    func setCalc (calc:Float) -> Float{
        calcTotal = calc;
        return calcTotal;
    }
    
    func returnPossibleTips() -> [Int: Double] {
        
        let possibleTipsInferred = [0.15, 0.18, 0.20]
        let possibleTipsExplicit:[Double] = [0.15, 0.18, 0.20]
        
        // 2
        var retval = Dictionary<Int, Double>()
        for possibleTip in possibleTipsInferred {
            let intPct = Int(possibleTip*100)
            // 3
            retval[intPct] = calcTipWithTipPct(possibleTip)
        }
        return retval
        
    }

}
