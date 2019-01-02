import UIKit
import os.log

class WorkoutEditorSelectorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let controlList = [ "Timer"/*, "Counter", "Pacer"*/]

    @IBAction func StartWorkoutButton(_ sender: Any) {
        saveWorkout()
    }
    @IBAction func AddExercise(_ sender: Any) {
        if(CreateExerciseTextEntry.hasText && SecRepsNumberEntry.hasText){
            workout.append(workoutBuilder(name: CreateExerciseTextEntry.text!, control: controlList[ControlPicker.selectedRow(inComponent: 0)], secReps: Int(SecRepsNumberEntry.text!)!))
            
            CreateExerciseTextEntry.text = nil
            SecRepsNumberEntry.text = nil
            ExerciseListTableView.reloadData()
            saveWorkout()
            
        }
        else if (!CreateExerciseTextEntry.hasText && SecRepsNumberEntry.hasText){
            workout.append(workoutBuilder(name: "Exercise", control: controlList[ControlPicker.selectedRow(inComponent: 0)], secReps: Int(SecRepsNumberEntry.text!)!))
            
            CreateExerciseTextEntry.text = nil
            SecRepsNumberEntry.text = nil
            ExerciseListTableView.reloadData()
            saveWorkout()
        }
        else if (CreateExerciseTextEntry.hasText && !SecRepsNumberEntry.hasText){
            workout.append(workoutBuilder(name: CreateExerciseTextEntry.text!, control: controlList[ControlPicker.selectedRow(inComponent: 0)], secReps: 10))
            
            CreateExerciseTextEntry.text = nil
            SecRepsNumberEntry.text = nil
            ExerciseListTableView.reloadData()
            saveWorkout()
        }
        else{
            workout.append(workoutBuilder(name: "Exercise", control: controlList[ControlPicker.selectedRow(inComponent: 0)], secReps: 1))
            
            CreateExerciseTextEntry.text = nil
            SecRepsNumberEntry.text = nil
            ExerciseListTableView.reloadData()
            saveWorkout()
        }
    }
    
    @IBOutlet weak var SecRepsNumberEntry: UITextField!
    @IBOutlet weak var CreateExerciseTextEntry: UITextField!
    @IBOutlet weak var ControlPicker: UIPickerView!
    @IBOutlet weak var ExerciseListTableView: UITableView!
    @IBOutlet weak var AddExerciseButton: UIButton!
    @IBOutlet weak var StartWorkoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ControlPicker.dataSource = self
        ControlPicker.delegate = self
        AddExerciseButton.layer.cornerRadius = 5
        StartWorkoutButton.layer.cornerRadius = 5
    }
    
    private func saveWorkout() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(workout, toFile: Exercise.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Workout successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save workout...", log: OSLog.default, type: .error)
        }
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




extension WorkoutEditorSelectorViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return controlList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(controlList[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return controlList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = controlList[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor: UIColor.yellow])
        
        return myTitle
    }
}

