//
//  AddContacts.swift
//  sqliteA
//
//  Created by Vadde Narendra on 12/22/19.
//  Copyright © 2019 Varalakshmi Kacherla. All rights reserved.
//

import UIKit
import SQLite

class AddContacts: UIViewController
{
    // MARK:- Declarations
    
    @IBOutlet weak var mainStackView: UIStackView!
    
    var dbConnection:Connection!
    var path:String!
    var db:Connection!
    var allStackView = [UIStackView]()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //MARK:- path creation & calling create table func
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        print(path)
        
        do
        {
            dbConnection = try Connection("\(path)ContactDetails.sqlite3")
        }
        catch
        {
            print("Unable To Connect")
        }
        
        SQLDatabase.shared.dbConnection = dbConnection
        
        createTable()
    }
    
    //MARK:- fetching data func calling
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    //MARK:- create table func
    
    func createTable()
    {
        do
        {
            try dbConnection.run("CREATE TABLE IF NOT EXISTS ContactDetails (id INTEGER PRIMARY KEY AUTOINCREMENT, firstName text, lastName text, mobileNo text)")
        }
        catch
        {
            print("Error While Creating Table")
        }
    }
    
    //MARK:- add contacts btn func
    
    @IBAction func addContactBtnTapped(_ sender: UIButton)
    {
        SQLDatabase.shared.isCreateBtnTab = true
        
        for x in allStackView
        {
            x.removeFromSuperview()
        }
        
        
        allStackView = [UIStackView]()
        
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "detailsSubmit") as! ViewController
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    //MARK:- fetching data func
    
    func fetchData()
    {
        for x in allStackView
        {
            x.removeFromSuperview()
        }
            
            
            allStackView = [UIStackView]()
            
            SQLDatabase.shared.firstNamesArray = [String]()
            SQLDatabase.shared.lastNameArray = [String]()
            SQLDatabase.shared.mobileNoArray = [String]()
            SQLDatabase.shared.idsArray = [Int64]()
            
            do
            {
            let fetchContacts = try SQLDatabase.shared.dbConnection.run("SELECT * FROM ContactDetails")
                
            var i = 0
            for row in fetchContacts
            {
                var firstNameTxt = String()
                var lastNameTxt = String()
                var mobileNoTxt = String()
                var idTxt = Int64()
                
                for (index, name) in fetchContacts.columnNames.enumerated()
                {
                    print ("\(name):\(row[index]!)")
                    
                    if(name == "firstName")
                    {
                        firstNameTxt = row[index] as! String
                    }
                    else if(name == "lastName")
                    {
                        lastNameTxt = row[index] as! String
                    }
                    else if(name == "mobileNo")
                    {
                        mobileNoTxt = row[index] as! String
                    }
                    else if(name == "id")
                    {
                        idTxt = row[index] as! Int64
                    }
                    
                }
                
                //MARK:- user Image
                
                let imageBtn = UIButton()
                imageBtn.setImage(UIImage(named: "noImage"), for: UIControl.State.normal)
                imageBtn.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                imageBtn.layer.borderWidth = 1
                imageBtn.layer.masksToBounds = false
                imageBtn.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                imageBtn.layer.cornerRadius = imageBtn.frame.height/2
                imageBtn.clipsToBounds = true
                imageBtn.translatesAutoresizingMaskIntoConstraints = false
                imageBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
                imageBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
                
                //MARK:- Name Label
                
                let nameLbl = UILabel()
                nameLbl.text = ("\(firstNameTxt) \(lastNameTxt)")
                nameLbl.font = UIFont.boldSystemFont(ofSize: 20)
                nameLbl.textColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
                nameLbl.textAlignment = .left
                
                //MARK:- mobileNo Label
                
                let mobileNoLbl = UILabel()
                mobileNoLbl.text = mobileNoTxt
                mobileNoLbl.font = UIFont.boldSystemFont(ofSize: 20)
                mobileNoLbl.textColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
                mobileNoLbl.textAlignment = .left
                
                //MARK:- Edit button
                
                let editBtn = UIButton()
                editBtn.setImage(UIImage(named: "edit"), for: UIControl.State.normal)
                editBtn.addTarget(self, action: #selector(editData(sender:)), for: UIControl.Event.touchUpInside)
                editBtn.layer.borderWidth = 2
                editBtn.layer.masksToBounds = false
                editBtn.layer.borderColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
                editBtn.layer.cornerRadius = imageBtn.frame.height/2
                editBtn.clipsToBounds = true
                editBtn.tag = i
                editBtn.translatesAutoresizingMaskIntoConstraints = false
                editBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
                editBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
                
                //MARK:- update button
                
                let updateBtn = UIButton()
                updateBtn.setImage(UIImage(named: "reload"), for: UIControl.State.normal)
                updateBtn.addTarget(self, action: #selector(updateData(sender:)), for: UIControl.Event.touchUpInside)
                updateBtn.layer.borderWidth = 2
                updateBtn.layer.masksToBounds = false
                updateBtn.layer.borderColor = #colorLiteral(red: 0, green: 0.2907733023, blue: 0.935197413, alpha: 1)
                updateBtn.layer.cornerRadius = imageBtn.frame.height/2
                updateBtn.clipsToBounds = true
                updateBtn.tag = i
                updateBtn.translatesAutoresizingMaskIntoConstraints = false
                updateBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
                updateBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true

                //MARK:- Delete button
                
                let deleteBtn = UIButton()
                deleteBtn.setImage(UIImage(named: "remove"), for: UIControl.State.normal)
                deleteBtn.addTarget(self, action: #selector(deleteData(sender:)), for: UIControl.Event.touchUpInside)
                deleteBtn.layer.borderWidth = 2
                deleteBtn.layer.masksToBounds = false
                deleteBtn.layer.borderColor = #colorLiteral(red: 0.846742928, green: 0.1176741496, blue: 0, alpha: 1)
                deleteBtn.layer.cornerRadius = imageBtn.frame.height/2
                deleteBtn.clipsToBounds = true
                deleteBtn.tag = i
                deleteBtn.translatesAutoresizingMaskIntoConstraints = false
                deleteBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
                deleteBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
                
                //MARK:- Image StackView
                
                let imageStackView = UIStackView(arrangedSubviews: [imageBtn])
                
                
                //MARK:- Label StackView
                
                let labelStackView = UIStackView(arrangedSubviews: [nameLbl, mobileNoLbl])
                labelStackView.axis = .vertical
                labelStackView.spacing = 2
                labelStackView.distribution = .fillEqually
                
                //MARK:- edit Stackview
                
                let editStackView = UIStackView(arrangedSubviews: [editBtn])
                
                //MARK:- delete stackview
                
                let deleteStackView = UIStackView(arrangedSubviews: [deleteBtn])
                
                //MARK:- update stackview
                
                let updateStackView = UIStackView(arrangedSubviews: [updateBtn])
                
                
                //MARK:- Main StackView
                
                let subStackView = UIStackView(arrangedSubviews: [imageStackView, labelStackView, editStackView, updateStackView, deleteStackView])
                subStackView.axis = .horizontal
                subStackView.alignment = .fill
                subStackView.distribution = .fill
                subStackView.spacing = 10
                allStackView.append(subStackView)
                
                mainStackView.addArrangedSubview(subStackView)
                
                SQLDatabase.shared.firstNamesArray.append(firstNameTxt)
                SQLDatabase.shared.lastNameArray.append(lastNameTxt)
                SQLDatabase.shared.mobileNoArray.append(mobileNoTxt)
                SQLDatabase.shared.idsArray.append(idTxt)
                
                i += 1
                
                }
            }
            catch
            {
                print("Unable to Fetch data")
            }
        }
        
        //MARK:- method to delete
    
        @objc func deleteData(sender:UIButton)
        {
            SQLDatabase.shared.deleteBtnTag = sender.tag
            
                do
                {
                    try self.dbConnection.run("DELETE FROM ContactDetails WHERE ID = \(SQLDatabase.shared.idsArray[SQLDatabase.shared.deleteBtnTag])")
                    
                    self.fetchData()
                    
                }
                catch
                {
                    print("Unable to delete data")
                }
        }
        
        //MARK:- method to edit
    
        @objc func editData(sender:UIButton)
        {
            SQLDatabase.shared.buttonTapped = sender.tag
            
            for x in allStackView
                    {
                        x.removeFromSuperview()
                    }
            
            
                    allStackView = [UIStackView]()
            SQLDatabase.shared.isCreateBtnTab = false
            
            let detailsVC = storyboard?.instantiateViewController(withIdentifier: "detailsSubmit") as! ViewController
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    
    //MARK:- method to update
    
    @objc func updateData(sender:UIButton)
    {
        SQLDatabase.shared.buttonTapped = sender.tag
        
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "detailsSubmit") as! ViewController
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}
