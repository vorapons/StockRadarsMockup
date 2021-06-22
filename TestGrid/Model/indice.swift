//
//  indice.swift
//  TestGrid
//
//  Created by Vorapon Sirimahatham on 7/6/21.
//

import Foundation

struct Indice : Codable {
    
    var name : String
    var value : String {
        return String(format: "%.2f", valueInDouble)
    }
    var change : String
    {
        return String(format: "%.2f", changeInDouble )
    }
    var percentChange : String
    {
        if( valueInDouble != lastTwoDaysClosedValue ) {
            if( lastTwoDaysClosedValue != 0 ) {
                return String( format: "%.2f", (valueInDouble - lastTwoDaysClosedValue)/lastTwoDaysClosedValue)
            } else { return "0.00"}
        }
        else
        {   if( lastClosedValue != 0) {
                return String( format: "%.2f", (valueInDouble - lastClosedValue)/lastClosedValue)
            }
            else { return "0.00"}
        }
    }
    var percentChangeInDouble : Double {
        if( valueInDouble != lastTwoDaysClosedValue ) {
            if( lastTwoDaysClosedValue != 0 ) {
                return (valueInDouble - lastTwoDaysClosedValue)/lastTwoDaysClosedValue
            } else { return 0.00}
        }
        else
        {   if( lastClosedValue != 0) {
                return (valueInDouble - lastClosedValue)/lastClosedValue
            }
            else { return 0.00 }
        }
    }
    var valueInDouble : Double
    var pastAdded : Bool
    var currentAdded : Bool
    var pastData : [DailyIndice]
    var lastClosedValue : Double
    var lastTwoDaysClosedValue : Double
    var changeInDouble : Double{
        if( valueInDouble == lastClosedValue )
        {    return valueInDouble - lastTwoDaysClosedValue }
        else
        {    return valueInDouble - lastClosedValue }
    }
    
    var isIndiceComplete : Bool {
        return name != "" && pastAdded && currentAdded
    }
    
    init()
    {
        name = ""
        valueInDouble = 0.0
        pastAdded = false
        currentAdded = false
        pastData = []
        lastClosedValue = 0.0
        lastTwoDaysClosedValue = 0.0
    }
}

struct IndiceStore {
    
    var indices = [Indice]()
    let APIKEY = "API_KEY16ZY2IEZSNXREQ0KXCHFMZLFZWQG1QFR"
    
    func getPassDataURLinStringBy( index name : String ) -> (String)
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today = Date()
        let last7Day = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        let todayString = formatter.string(from: today)
        let last7daysString = formatter.string(from: last7Day!)
    
        return "https://api.finage.co.uk/agg/index/\(name)/1day/\(last7daysString)/\(todayString)?apikey=" + APIKEY
    }
    
    func getCurrentDataURLinStringBy( index name : String ) -> (String)
    {
        return "https://api.finage.co.uk/last/index/\(name)?apikey=" + APIKEY
    }
    
//    var queryList = ["HSI", "N225", "DJI", "COMP", "GSPC","GDAXI","ATX","STI","FTAS"]
    var queryList = ["HSI"]
    
    mutating func addIndiceCurrentData( data : CurrentIndice )
    {
        // find indice from symbol , if not found create new then append
        let index = indices.firstIndex(where: { $0.name == data.symbol } )
        
        if (self.indices.isEmpty || index == nil )  {
            var input = Indice()
            input.name = data.symbol
            input.valueInDouble = data.price
            input.currentAdded = true
            self.indices.append(input)
        }
        else
        {
            indices[index!].valueInDouble = data.price
            indices[index!].currentAdded = true
        }
    }
    
    mutating func addIndicePastData( data : PastIndice )
    {
        // find indice from symbol , if not found create new then append
        let index = indices.firstIndex(where: { $0.name == data.symbol } )
        
        if (self.indices.isEmpty || index == nil )  {
            // create new Indice data to Store
            var input = Indice()
            input.name = data.symbol
//            input.pastData = data.results
            input.lastClosedValue = Double( data.results[0].c ) ?? 0.0
            input.lastTwoDaysClosedValue = Double( data.results[1].c ) ?? 0.0
            input.pastAdded = true
            self.indices.append(input)
        }
        else
        {
            // for already has this name in Store, udpdate data
//            indices[index!].pastData = data.results
            indices[index!].lastClosedValue = Double( data.results[0].c ) ?? 0.0
            indices[index!].lastTwoDaysClosedValue = Double( data.results[1].c ) ?? 0.0
            indices[index!].pastAdded = true
        }
    }
    
    mutating func getIndiceDataBy( name : String ) -> Indice? {
            return Indice()
    }
}

struct CurrentIndice : Codable {
    
    var name : String {
        return symbol
    }
    var symbol : String
    var price : Double
    var timestamp : Int
    
    init()
    {
        symbol = ""
        price = 0.0
        timestamp = 0
    }
}

struct PastIndice : Codable {
    var symbol : String = ""
    var results : [DailyIndice] = []
}

struct DailyIndice : Codable {
    var o : String
    var h : String
    var l : String
    var c : String
    var t : String
    var v : String
}

// - - - - - - - - - - - - - - - - - - - - -
// Mock data for test and dev
// - - - - - - - - - - - - - - - - - - - - -
let json = """
[
    {
        "name": "Dow",
        "value": "34,687.15",
        "change": "+111.84",
        "percentChange": "+0.32"
    },
    {
        "name": "Nasdaq",
        "value": "13,767.77",
        "change": "+31.29",
        "percentChange": "+0.23"
    },
    {
        "name": "S&P 500",
        "value": "4,214.73",
        "change": "+12.69",
        "percentChange": "+0.30"
    },
    {
        "name": "Hang Seng",
        "value": "29.297.62",
        "change": "-170.38",
        "percentChange": "-0.58"
    },
    {
        "name": "Nikkei 225",
        "value": "28,946.14",
        "change": "+131.80",
        "percentChange": "+0.46"
    }
]
"""

let last7dayJSON = """
    {"symbol":"N225","totalResults":5,"results":[
    {"o":"29214.00000","h":"29241.19922","l":"28973.05078","c":"29005.74023","v":"0","t":"2021-06-07T12:00:00"}
    ,{"o":"29046.02930","h":"29140.67969","l":"28897.64062","c":"28959.33008","v":"0","t":"2021-06-08T12:00:00"}
    ,{"o":"28901.56055","h":"28932.02930","l":"28801.83008","c":"28869.71094","v":"0","t":"2021-06-09T12:00:00"}
    ,{"o":"28799.74023","h":"29007.52930","l":"28799.74023","c":"28984.75977","v":"0","t":"2021-06-10T12:00:00"}
    ,{"o":"29030.03906","h":"29080.89062","l":"28839.53906","c":"28947.84961","v":"0","t":"2021-06-11T12:00:00"}]}
"""


let requestCurrent = "https://api.finage.co.uk/last/index/N225?apikey=API_KEY16ZY2IEZSNXREQ0KXCHFMZLFZWQG1QFR"
let requestLast7Days = "https://api.finage.co.uk/agg/index/n225/1day/2021-06-07/2021-06-14?apikey=API_KEY16ZY2IEZSNXREQ0KXCHFMZLFZWQG1QFR"

let currentJSON = """
    {"symbol":"N225","price":28947.84961,"timestamp":1623600373634}
    """

let HSIlast7daysJSON = """
    {"symbol":"HSI","totalResults":5,"results":[{"o":"28985.59961","h":"29003.99023","l":"28615.60938","c":"28778.83008","v":"0","t":"2021-06-07T12:00:00"},{"o":"28900.51953","h":"28979.19922","l":"28638.31055","c":"28763.66992","v":"0","t":"2021-06-08T12:00:00"},{"o":"28781.66992","h":"28859.58008","l":"28687.68945","c":"28747.24023","v":"0","t":"2021-06-09T12:00:00"},{"o":"28792.01953","h":"28954.40039","l":"28664.93945","c":"28707.42969","v":"0","t":"2021-06-10T12:00:00"},{"o":"28864.90039","h":"28965.15039","l":"28743.82031","c":"28847.75000","v":"0","t":"2021-06-11T12:00:00"}]}
"""
let DJIlast7daysJSON = """
{"symbol":"DJI","totalResults":5,"results":[{"o":"34766.19922","h":"34820.91016","l":"34574.51172","c":"34629.96875","v":"209269593","t":"2021-06-07T12:00:00"},{"o":"34645.83984","h":"34665.37891","l":"34452.94141","c":"34600.05078","v":"237170826","t":"2021-06-08T12:00:00"},{"o":"34626.16016","h":"34654.67188","l":"34439.37109","c":"34446.87891","v":"203109309","t":"2021-06-09T12:00:00"},{"o":"34502.51172","h":"34737.78906","l":"34447.25000","c":"34459.35156","v":"248746853","t":"2021-06-10T12:00:00"},{"o":"34499.80859","h":"34618.08984","l":"34328.64844","c":"34477.60938","v":"213084330","t":"2021-06-11T12:00:00"}]}
"""
