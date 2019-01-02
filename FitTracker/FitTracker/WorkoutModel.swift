import Foundation

var workout: [Exercise] = []

func workoutBuilder(name: String, control: String, secReps: Int) -> Exercise {
    let temp: Exercise = Exercise.init(name: name, control: control, secReps: secReps)
    
    return temp
}

func loadWorkout() -> [Exercise]? {
    
    return NSKeyedUnarchiver.unarchiveObject(withFile: Exercise.ArchiveURL.path) as? [Exercise]
}


