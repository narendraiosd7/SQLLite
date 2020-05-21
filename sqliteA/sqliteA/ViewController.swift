
import UIKit

import SQLite

class ViewController: UIViewController
{
    //MARK:- Declaration
    
    @IBOutlet var firstNameTF: UITextField!
    @IBOutlet var lastNameTF: UITextField!
    @IBOutlet weak var mobileNoTF: UITextField!
    
    var dbConnection:Connection!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        dbConnection = SQLDatabase.shared.dbConnection
    }
    
    //MARK:- viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        
        if(SQLDatabase.shared.isCreateBtnTab == false)
        {
            firstNameTF.text = SQLDatabase.shared.firstNamesArray[SQLDatabase.shared.buttonTapped]
            lastNameTF.text = SQLDatabase.shared.lastNameArray[SQLDatabase.shared.buttonTapped]
            mobileNoTF.text = SQLDatabase.shared.mobileNoArray[SQLDatabase.shared.buttonTapped]
        }
    }
    
    //MARK:- save btn action
    
    @IBAction func saveBtnTapped(_ sender: Any)
    {
        insetData(firstName: firstNameTF.text!, lastName: lastNameTF.text!, mobileNo: mobileNoTF.text!)
        
        dismiss(animated: true, completion: nil)
        
    }
    
    //MARK:- update btn action
    
    @IBAction func updateBtnTapped(_ sender: UIButton)
    {
        updateData()
    }
    
    //MARK:- insert data method
    
    func insetData(firstName:String, lastName:String, mobileNo:String)
    {
        do
        {
            
            try dbConnection.run("INSERT INTO ContactDetails (firstName, lastName, mobileNo) VALUES(?,?,?)",firstName,lastName, mobileNo)
        }
        catch
        {
            print("Catch Error : failed to insert ")
        }
    }
    
    //MARK:- update data method
    
    func updateData()
    {
        
        do
        {
            
            try self.dbConnection.run("UPDATE Contacts SET firstName = '\(self.firstNameTF.text!)', lastName = '\(self.lastNameTF.text!)', mobileNo = '\(self.mobileNoTF.text!)' WHERE ID = \(SQLDatabase.shared.idsArray[SQLDatabase.shared.buttonTapped])")
            
            self.navigationController?.popViewController(animated: true)
            
            
        }
        catch
        {
            print("Catch Error : failed to update ")
        }
    }
}

