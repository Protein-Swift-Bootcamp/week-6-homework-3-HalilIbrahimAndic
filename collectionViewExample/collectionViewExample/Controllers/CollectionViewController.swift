//
//  CollectionViewController.swift
//  collectionViewExample
//
//  Created by Halil Ibrahim Andic on 10.01.2023.
//

import UIKit

class CollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
     
    private var artworks = ArtModel(data: [Datum(artist_display: "", image_id: "e966799b-97ee-1cc6-bd2f-a94b4b8bb8f9", title: "")])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }
    
    private func setupUI() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(.init(nibName: "SampleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SampleCollectionViewCell")
    }
    
    func fetchData() {
        // 1. Create the URL
        if let url = URL(string: "https://api.artic.edu/api/v1/artworks/search?query[term][is_boosted]=true&fields[]=title&fields[]=artist_display&fields[]=image_id&limit=14") {
            
            // 2. Create the Session
            let session = URLSession.shared

            // 3. Create the Request
            var request: URLRequest = .init(url: url)
            request.httpMethod = "GET"
            
            // 4. Give session a task with the request
            let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
                if error != nil {
                    print("Task not completed!")
                    return
                }
                
                // make sure we have data to decode
                if let data = data {
                    //call our JSON parsing function
                    self.parseJson(data)
                }
            }
            //5. Start the task
            task.resume()
        }
    }
    
    // this function decodes incoming data
    func parseJson(_ data: Data) {
        do {
            // decode incoming data wrt my setup declared in HPModel
            let artworks = try JSONDecoder().decode(ArtModel.self, from: data)
            DispatchQueue.main.async {
                self.artworks = artworks
            }
            
            // Things to do when the data is ready to show
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } catch {
            print("decoding error")
        }
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width / 2, height: collectionView.frame.height/2)
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artworks.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SampleCollectionViewCell", for: indexPath) as! SampleCollectionViewCell
        
        let textDisplay = artworks.data[indexPath.row].title + "\n" + artworks.data[indexPath.row].artist_display
        cell.titleLabel.text = textDisplay

        
        do {
            let imageID = artworks.data[indexPath.row].image_id
            let imageURL = URL(string: "https://www.artic.edu/iiif/2/\(imageID)/full/200,/0/default.jpg")
            //print(artworks.data[indexPath.row].thumbnail.width)
            
            let imageData = try Data(contentsOf: imageURL!)
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: imageData)
            }
        } catch {
            print("Display error: \(error)")
        }

        return cell
    }
}
