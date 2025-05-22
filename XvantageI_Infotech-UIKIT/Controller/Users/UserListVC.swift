//
//  UserListVC.swift
//  XvantageI_Infotech-UIKIT
//
//  Created by Nimish Mothghare on 21/05/25.
//

import UIKit

class UserListVC: UIViewController {
    
    //MARK: -IBOutlet
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var userstblView: UITableView!
    
    var userlist_data : [LoginData] = []
    let coreDataManager = CoreDataManager()

    
    
    //MARK: -View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.userstblView.dataSource = self
        self.userstblView.delegate = self
        fetchAndReloadData()
        
        
        userstblView.register(UINib(nibName: "UserTableVC", bundle: nil), forCellReuseIdentifier: "UserTableVC")
        
    }
    
    
    func fetchAndReloadData() {
        userlist_data = coreDataManager.fetchUserData()
        for user in userlist_data {
          print("The Users Data \(user)")
        }
        userstblView.reloadData()
        
    }
    
    
    //MARK: -Back IBAction 
    @IBAction func backAction(_ sender: UIButton) {
        
        
    }
    

}

//MARK: -UITableViewDelegate
extension UserListVC : UITableViewDelegate {
    
    
}

//MARK: -UITableViewDataSource
extension UserListVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userlist_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userstblView.dequeueReusableCell(withIdentifier: "UserTableVC", for: indexPath) as! UserTableVC
        cell.nameLbl.text = userlist_data[indexPath.row].name
        cell.emailLbl.text = userlist_data[indexPath.row].email
        cell.phonenoLbl.text = userlist_data[indexPath.row].phonenumber
        cell.profileImg.image = UIImage(data: userlist_data[indexPath.row].profileimg!)
        return cell
    }
    
    
    
}


