//
//  FavouritesTableViewController.swift
//  FlickrPhotoViewApp
//
//  Created by Priyanka PS on 5/6/21.
//

import UIKit

class FavouritesTableViewController: UITableViewController {
    var favouritePhotsArray = [Photo]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        readFromUserDefaults()
        self.tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(favouritePhotsArray.count)
        return favouritePhotsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouritePhotoTableviewCell", for: indexPath)as! FavouritePhotoTableViewCell
        let item = favouritePhotsArray[indexPath.row]
        // Configure the cell...
        cell.photoTitleLabel.text = item.title
        cell.photoGrapherNameLabel.text = item.name
        cell.configure(for: item, photoDataController: PhotoDataController.shared)
        if favouritePhotsArray.contains(item) {
          print("Item found")
            cell.favouriteButton.setImage(UIImage(systemName: "star.circle.fill"), for:.normal)

   } else {
      print("not Found")
         cell.favouriteButton.setImage(UIImage(systemName: "star.circle"), for:.normal)
     }
        cell.favouriteButton.tag = indexPath.row
        cell.favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped(sender:)), for: .touchUpInside)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func readFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: "favList") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                favouritePhotsArray = try decoder.decode([Photo].self, from: data)

            } catch {
                print("Unable to Decode Photos (\(error))")
            }
        }
    }
    func saveToUserDefaults(favouriteItems:[Photo]) {
        
        let favourites = favouriteItems
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(favourites)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "favList")

        } catch {
            print("Unable to Encode Array of Notes (\(error))")
        }
    }
    
    
    @objc func favouriteButtonTapped(sender:UIButton) {
      
        let cell = self.tableView.cellForRow(at: IndexPath.init(row: sender.tag, section: 0))
        let item = self.favouritePhotsArray[sender.tag]
        if favouritePhotsArray.contains(item) {
            print("Item found")
            favouritePhotsArray.removeAll { $0 == item}
            sender.setImage(UIImage(systemName: "star.circle"), for:.normal)
        } else {
            print("not Found")
            favouritePhotsArray.append(item)
            sender.setImage(UIImage(systemName: "star.circle.fill"), for:.normal)
        }
        saveToUserDefaults(favouriteItems: favouritePhotsArray)
    }

    func setGradientBackground() {
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}
