//
//  UserListVC.swift
//  XvantageI_Infotech-UIKIT
//
//  Created by Nimish Mothghare on 21/05/25.
//

import UIKit


protocol UserListDataPass : AnyObject {
    
    func userData(users : LoginData)
}

class UserListVC: UIViewController {
    
    //MARK: -IBOutlet
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var userstblView: UITableView!
    
    var userlist_data : [LoginData] = []
    let coreDataManager = CoreDataManager()

    weak var userdelegate : UserListDataPass?

    
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
        
        self.navigationController?.popViewController(animated: true)

    }
    
    
    @objc func deletedtapped(sender : UIButton) {
        
        let userdata = self.userlist_data[sender.tag]
        print("Print the user data \(userdata)")
        coreDataManager.deleteUserData(user:userdata)
        
        
        userlist_data.remove(at: sender.tag)

        self.userstblView.reloadData()
        
    }
    
    
    @objc func edittapped(sender : UIButton) {
        
        
        let selectedData = userlist_data[sender.tag]
               self.userdelegate?.userData(users: selectedData)
               
               if let targetVC = navigationController?.viewControllers.first(where: { $0 is LoginVC }) as? LoginVC {
                   targetVC.isEditMode = true
                   targetVC.usertoEdit = selectedData
                   navigationController?.popToViewController(targetVC, animated: true)
               }
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
        
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deletedtapped), for: .touchUpInside)
        
        cell.editBtn.tag = indexPath.row
        cell.editBtn.addTarget(self, action: #selector(edittapped), for: .touchUpInside)
        
        
        return cell
    }
    
    
    
}


