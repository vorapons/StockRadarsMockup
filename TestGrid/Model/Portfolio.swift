//
//  Portfolio.swift
//  TestGrid
//
//  Created by Vorapon Sirimahatham on 7/6/21.
//

import Foundation

struct Portfolio : Codable, Hashable {
    var title : String
    var image_plan_bg : URL
    var image_plan : URL
    var withdrawable_point : Double
    var pending_point : Double
    var cost : Double
    var change : Double
}


let portJSON = """
[
    {
        "title": "Apple",
        "image_plan_bg": "https://storage.radarspoint.com/radars-point-images/plan/background/Head_Apple.jpg",
        "image_plan": "https://storage.radarspoint.com/radars-point-images/plan/apple.jpg",
        "withdrawable_point": 1611.9,
        "pending_point": 0.18000000000000002,
        "cost": 1450.2088,
        "change": 161.69
    },
    {
        "title": "แผนการลงทุนอัตโนมัติ",
        "image_plan_bg": "https://storage.radarspoint.com/radars-point-images/plan/background/Head_Main.jpg",
        "image_plan": "https://storage.radarspoint.com/radars-point-images/plan/radars_point.jpg",
        "withdrawable_point": 527.99,
        "pending_point": 19.35,
        "cost": 309.177,
        "change": 218.82
    },
    {
        "title": "Facebook",
        "image_plan_bg": "https://storage.radarspoint.com/radars-point-images/plan/background/Head_Facebook.jpg",
        "image_plan": "https://storage.radarspoint.com/radars-point-images/plan/facebook.jpg",
        "withdrawable_point": 260.81,
        "pending_point": 0,
        "cost": 219.58,
        "change": 41.23
    },
    {
        "title": "Tesla",
        "image_plan_bg": "https://storage.radarspoint.com/radars-point-images/plan/background/Head_Tesla.jpg",
        "image_plan": "https://storage.radarspoint.com/radars-point-images/plan/tesla.jpg",
        "withdrawable_point": 167.56,
        "pending_point": 0,
        "cost": 98.71,
        "change": 68.85
    },
    {
        "title": "Haidilao Hot Pot",
        "image_plan_bg": "https://storage.radarspoint.com/radars-point-images/plan/background/Head_HaiDiLao.jpg",
        "image_plan": "https://storage.radarspoint.com/radars-point-images/plan/HaiDiLao.jpg",
        "withdrawable_point": 100,
        "pending_point": 0,
        "cost": 100,
        "change": 0
    }
]
"""

