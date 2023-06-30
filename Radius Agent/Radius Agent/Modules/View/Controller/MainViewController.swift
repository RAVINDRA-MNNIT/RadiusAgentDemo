//
//  MainViewController.swift
//  Radius Agent
//
//  Created by Ravindra Arya on 28/06/23.
//

import UIKit

class MainViewController: UIViewController {

    var homeViewModel = HomeViewModel()
    var facilities: [Facility]?
    var exclusionCondition : [String : (String,String)] = [:]
    var exclusions : [String : String] = [:]
    @IBOutlet weak var tableView: UITableView!
    {
        didSet
        {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: "OptionTableViewCell")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.delegate = self
        homeViewModel.getHomeData()
    }
}

extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return facilities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facilities![section].options.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionTableViewCell") as! OptionTableViewCell
        cell.cellButton.setTitle(facilities![indexPath.section].options[indexPath.row].name, for: .normal)
        cell.cellButton.setImage(UIImage(named: facilities![indexPath.section].options[indexPath.row].icon), for: .normal)
        cell.cellButton.setTitleColor(UIColor.systemBlue, for: .normal)

        
        if facilities![indexPath.section].options[indexPath.row].isSelected == true
        {
            cell.checkBoxIcon.image = UIImage(named: "check")
        }
        else
        {
            cell.checkBoxIcon.image = UIImage(named: "uncheck")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionButton = UIButton()
        sectionButton.setTitle(facilities![section].name,
                               for: .normal)
        sectionButton.backgroundColor = .systemBlue
        return sectionButton
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
  
        if facilities![indexPath.section].options[indexPath.row].isSelected == true
        {
            facilities![indexPath.section].options[indexPath.row].isSelected = false
            facilities![indexPath.section].isFacilitySelected = false
            let key = (facilities![indexPath.section].facilityID) + "," + (facilities![indexPath.section].options[indexPath.row].id)
            exclusions.removeValue(forKey: key)
            tableView.reloadData()
        }
        else
        {
            if facilities![indexPath.section].isFacilitySelected == true
            {
                showAlert(message: Message.noMultipleOption.rawValue)
                return
            }
            let excluded = exclusionCondition[(facilities![indexPath.section].facilityID) + "," + (facilities![indexPath.section].options[indexPath.row].id)]
            let key = (excluded?.0 ?? "") + "," + (excluded?.1 ?? "")
            if exclusions[key] != nil &&  exclusions[key] != ""
            {
                showAlert(message: Message.exclusionMessage.rawValue.replacingOccurrences(of: "*", with: exclusions[key] ?? ""))
                return
            }
            else
            {
                facilities?[indexPath.section].options[indexPath.row].isSelected = true
                facilities![indexPath.section].isFacilitySelected = true
     
                if excluded != nil
                {
                    exclusions[(facilities?[indexPath.section].facilityID ?? "") + "," + (facilities?[indexPath.section].options[indexPath.row].id ?? "")] = (facilities?[indexPath.section].options[indexPath.row].name ?? "") + " in " + (facilities?[indexPath.section].name ?? "")
                }
                tableView.reloadData()
            }
        }
    }
}

extension MainViewController : HomeViewModelDelegate
{
    func didReceiveHomeResponse(homeResponse: HomeResponseModel?) {
        facilities = homeResponse?.facilities
        guard let exclusions = homeResponse?.exclusions else {return}
        for i in 0..<exclusions.count
        {
            if exclusions[i].count == 2
            {
                let one = exclusions[i][0].facilityID
                let two = exclusions[i][0].optionsID
                let three = exclusions[i][1].facilityID
                let four = exclusions[i][1].optionsID
                
                exclusionCondition[one+","+two] = (three,four)
                exclusionCondition[three+","+four] = (one,two)
    
            }
        }
        tableView.reloadData()
    }
}

extension MainViewController
{
    fileprivate func showAlert(message : String)
    {
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
