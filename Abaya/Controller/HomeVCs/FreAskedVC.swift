//
//  FreAskedVC.swift
//  Blocks
//
//  Created by Khaled Bohout on 7/3/20.
//  Copyright © 2020 Khaled Bohout. All rights reserved.
//

import UIKit

class FreAskedVC: UIViewController {

    @IBOutlet weak var questionsTableView: UITableView!
    var fAQArr = [Question]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionsTableView.delegate = self
        questionsTableView.dataSource = self
        getFAQApi()
        // Do any additional setup after loading the view.
    }
    
    func getFAQApi()
    {
        hud.show(in: self.view)
        ApiBaseClass.apiCallingWithGetMethode(url:ApiBaseClass.getFAQ(), completion: { [weak self] response in
            let errorCheck = response["success"] as! Bool
            var dic = NSDictionary()
            dic = response as NSDictionary
            if errorCheck
            {
                

                let questionsArr = dic["data"] as! [[String : String]]
                for question in questionsArr {
                    let ques = Question(question: question["question"]!, answer: question["answer"]!)
                    self?.fAQArr.append(ques)
                }
                hud.dismiss()
                self?.questionsTableView.reloadData()
                
            }
            else
            {
                hud.dismiss()
                Alert.Show(title:NSLocalizedString("something wrong", comment: ""), mesage: NSLocalizedString("Please try again.", comment: ""), viewcontroller:self!)
                                    
                }
                    }, failure: { [weak self] failResponse in
                                    hud.dismiss()
                                    Alert.Show(title: NSLocalizedString("network error", comment: ""), mesage:NSLocalizedString("Please try again.", comment: "") , viewcontroller:self!)
        })
    }


}

extension FreAskedVC: UITableViewDelegate, UITableViewDataSource {
    
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           

           let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTableViewCell", for: indexPath as IndexPath) as! QuestionTableViewCell
           
        cell.configureCell(qusetion: fAQArr[indexPath.row])
    
               return cell

       }

       
       func numberOfSections(in tableView: UITableView) -> Int {
           
           return 1
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {


           
        return fAQArr.count

       }
       

       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
       {

        return 250


       }

}
