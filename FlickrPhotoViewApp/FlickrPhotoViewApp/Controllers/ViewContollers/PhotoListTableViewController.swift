//
//  PhotoListTableViewController.swift
//  FlickrPhotoViewApp
//
//  Created by Priyanka PS on 5/6/21.
//

import UIKit

class PhotoListTableViewController: UITableViewController {
    private var photosList = [Photo]()
    var favouriteListArray = [Photo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        PhotoDataController.shared.getPhotosFromFlickrAPI { (result) in
            switch result {
            case .success(let photosModel):
                self.photosList = photosModel.photos.photo
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
               
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        readFromUserDefaults()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.photosList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as! PhotoTableViewCell

        // Configure the cell...
        let item = self.photosList[indexPath.row]
       // cell.photoTitleLabel.text = item.title
       // cell.photoGrapherNameLabel.text = item.name
        cell.configure(for: item, storeItemController: PhotoDataController.shared)
        if favouriteListArray.contains(item) {
            print("Item found")
            cell.favouriteButton.setImage(UIImage(systemName: "star.circle"), for:.normal)
                                          
        } else {
            print("not Found")
            cell.favouriteButton.setImage(UIImage(systemName: "star.circle.fill"), for:.normal)
            
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

    func updateUI() {
        
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
    
    func readFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: "favList") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                favouriteListArray = try decoder.decode([Photo].self, from: data)

            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
    }
    
    @objc func favouriteButtonTapped(sender:UIButton) {
      
        let cell = self.tableView.cellForRow(at: IndexPath.init(row: sender.tag, section: 0))
        let item = self.photosList[sender.tag]
        if favouriteListArray.contains(item) {
            print("Item found")
            favouriteListArray.removeAll { $0 == item}
            sender.setImage(UIImage(systemName: "star.circle"), for:.normal)
        } else {
            print("not Found")
            favouriteListArray.append(item)
            sender.setImage(UIImage(systemName: "star.circle.fill"), for:.normal)
        }
        saveToUserDefaults(favouriteItems: favouriteListArray)
    }
    
}
