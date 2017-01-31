import UIKit

class OtherTripTVC: UITableViewController {
	
	var trips = [["San Francisco", "Livermore"], ["Las Vegas", "Los Angeles", "San Diego"], ["Yosemite", "Yreka", "Eureka"]]
	var people = ["Josh's Trips", "Gary's Trips", "Nick's Trips"]
	var correctSection = 0
	var count = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	//    override func numberOfSections(in tableView: UITableView) -> Int {
	//        return 0
	//    }
	override func numberOfSections(in tableView: UITableView) -> Int {
		
		return people.count
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return people[section]
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return trips[section].count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "OtherTripCell", for: indexPath)
		if count == 3 {
			correctSection += 1
			count = 0
		}
		
		cell.textLabel?.text = trips[correctSection][indexPath.row]

		count += 1
		
		return cell
	}
	
	
}
