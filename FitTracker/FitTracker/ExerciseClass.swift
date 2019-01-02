import Foundation
import os.log

class Exercise: NSObject, NSCoding {
    
    private var name: String
    private var control: String
    private var secReps: Int
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("exercises")
    
    override init() {
        self.name = "Exercise"
        self.control = "Timer"
        self.secReps = 10
    }
    
    init (name: String, control: String, secReps: Int) {
            self.name = name
            self.control = control
            self.secReps = secReps
    }
    
    func setExercise(name: String, control: String, secReps: Int){
        self.name = name
        self.control = control
        self.secReps = secReps
    }
    
    func getName() -> String{
        return name
    }
    
    func getControl() -> String {
        return control
    }
    
    func getSecReps() -> Int {
        return secReps
    }
    
    
    //code for saving exercises
    struct PropertyKey {
        static let name = "name"
        static let control = "control"
        static let secReps = "secReps"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(control, forKey: PropertyKey.control)
        aCoder.encode(secReps, forKey: PropertyKey.secReps)
    }//MARK: NSCoding
    
    required convenience init?(coder aDecoder: NSCoder) {

        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for an Exercise object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let control = aDecoder.decodeObject(forKey: PropertyKey.control) as? String else {
            os_log("Unable to decode the control for an Exercise object.", log: OSLog.default, type: .debug)
            return nil
        }
        let secReps = aDecoder.decodeInteger(forKey: PropertyKey.secReps)
        
        self.init(name: name, control: control, secReps: secReps)
        return nil
    }
    
    
    //code for loading workouts
    
    
}
