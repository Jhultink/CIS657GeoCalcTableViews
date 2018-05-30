//
//  HistoryTableViewController.swift
//  GeoCalcForiOS
//
//  Created by BDO on 5/29/18.
//  Copyright © 2018 Jaredt. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    var historyDelegate : HistoryTableViewControllerDelegate?
    
    var entries : [LocationLookup] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.entries = [LocationLookup(origLat: 90.0, origLng: 0.0, destLat: -90.0, destLng: 0.0, timestamp: Date.distantPast), LocationLookup(origLat: -90.0, origLng: 0.0, destLat: 90.0, destLng: 0.0, timestamp: Date.distantFuture)]
        
        self.sortIntoSections(entries: self.entries)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if let data = self.tableViewData {
            return data.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section:
        Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let sectionInfo = self.tableViewData?[section] {
            return sectionInfo.entries.count
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath:
        IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FancyCell", for:
            indexPath) as! HistoryTableViewCell
        //let ll = entries[indexPath.row]
        if let ll = self.tableViewData?[indexPath.section].entries[indexPath.row] {
            cell.origPoint.text = "(\(ll.origLat.roundTo(places:4)),\(ll.origLng.roundTo(places:4)))"
            cell.destPoint.text = "(\(ll.destLat.roundTo(places:4)),\(ll.destLng.roundTo(places: 4)))"
            cell.timestamp.text = ll.timestamp.description
        }
        return cell
    }
    
    var tableViewData: [(sectionHeader: String, entries: [LocationLookup])]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, titleForHeaderInSection
        section: Int) ->
        String? {
            return self.tableViewData?[section].sectionHeader
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath:
        IndexPath) ->
        CGFloat {
            return 200.0
    }
    override func tableView(_ tableView: UITableView, willDisplayFooterView view:
        UIView, forSection
        section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = FOREGROUND_COLOR
        header.contentView.backgroundColor = BACKGROUND_COLOR
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view:
        UIView,
                            forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = FOREGROUND_COLOR
        header.contentView.backgroundColor = BACKGROUND_COLOR
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // use the historyDelegate to report back entry selected to the calculator scene
        if let del = self.historyDelegate {
            if let ll = self.tableViewData?[indexPath.section].entries[indexPath.row] {
                
                del.selectEntry(entry: ll)
            }
        }
        // this pops to the calculator
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func sortIntoSections(entries: [LocationLookup]) {
        var tmpEntries : Dictionary<String,[LocationLookup]> = [:]
        var tmpData: [(sectionHeader: String, entries: [LocationLookup])] = []
        // partition into sections
        for entry in entries {
            let shortDate = entry.timestamp.short
            if var bucket = tmpEntries[shortDate] {
                bucket.append(entry)
                tmpEntries[shortDate] = bucket
            } else {
                tmpEntries[shortDate] = [entry]
            }
        }
        // breakout into our preferred array format
        let keys = tmpEntries.keys
        for key in keys {
            if let val = tmpEntries[key] {
                tmpData.append((sectionHeader: key, entries: val))
            }
        }
        // sort by increasing date.
        tmpData.sort { (v1, v2) -> Bool in
            if v1.sectionHeader < v2.sectionHeader {
                return true
            } else {
                return false
            }
        }
        self.tableViewData = tmpData
    }
}

protocol HistoryTableViewControllerDelegate {
    func selectEntry(entry: LocationLookup)
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
extension Date {
    struct Formatter {
        static let short: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
    }
    var short: String {
        return Formatter.short.string(from: self)
    }
}
