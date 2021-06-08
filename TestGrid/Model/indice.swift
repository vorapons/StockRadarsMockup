//
//  indice.swift
//  TestGrid
//
//  Created by Vorapon Sirimahatham on 7/6/21.
//

import Foundation

struct Indice : Codable {
    
    var name : String
    var value : String
    var change : String
    var percentChange : String
    
}

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

