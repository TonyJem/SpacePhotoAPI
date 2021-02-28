import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    let photoInfoController = PhotoInfoController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = ""
        
        activityIndicator.isHidden = false
        photoInfoController.fetchPhotoInfo { (photoInfo) in
            guard let photoInfo = photoInfo else { return }
            self.updateUI(with: photoInfo)
        }
    }
    
    func updateUI(with photoInfo: PhotoInfo) {
        
        let task = URLSession.shared.dataTask(with: photoInfo.url) {(data, response, error) in
            guard let data = data,
                  let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.title = photoInfo.title
                self.photoImageView.image = image
                self.descriptionLabel.text = photoInfo.description
                self.activityIndicator.isHidden = true
            }
        }
        task.resume()
    }
}
