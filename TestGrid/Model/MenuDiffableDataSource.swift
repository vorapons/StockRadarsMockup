//
//  MenuDiffableDataSource.swift
//  TestGrid
//
//  Created by Vorapon Sirimahatham on 7/6/21.
//

import UIKit

enum Section {
    case all
}

class MenuDiffableDataSource: UITableViewDiffableDataSource <Section,String> {

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         
            return true
        }

        
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let menus = self.itemIdentifier(for: indexPath) {
                var snapshot = self.snapshot()
                snapshot.deleteItems([menus])
                self.apply(snapshot,animatingDifferences: true)
            }
        }
    }
}
