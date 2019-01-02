import UIKit
//
//guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
//    os_log("Unable to decode the name for an Exercise object.", log: OSLog.default, type: .debug)
//    return nil
//}
class WorkoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBAction func PauseResume(_ sender: Any) {
    }
    @IBOutlet weak var EndWorkoutButton: UIButton!
    @IBOutlet weak var PauseResumeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        PauseResumeButton.layer.cornerRadius = 5
        EndWorkoutButton.layer.cornerRadius = 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(workout.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let exercise = workout[indexPath.row].getName()
        let exerciseCell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Exercise")
        if (workout.count == 0)
        {
            exerciseCell.textLabel?.textColor = UIColor.yellow
            exerciseCell.textLabel?.backgroundColor = UIColor.purple
            return exerciseCell
            
        }
        else
        {
            exerciseCell.textLabel?.text = exercise
            exerciseCell.textLabel?.textColor = UIColor.yellow
            exerciseCell.backgroundColor = UIColor.purple
            return exerciseCell
        }
    }

    
}
