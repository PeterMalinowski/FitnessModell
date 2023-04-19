using FitnessModellDBI.Models;

using var db = new FitnessDBContext();

Console.WriteLine("Add a new Excersie!");
//var car = new Car() { Brand = "Porsche", Color = "Grün", EngineType = "Verbenner", Mileage=0, ModelName="911", ModelYear = 2000};
Console.WriteLine("Name");
var name = Console.ReadLine();
Console.WriteLine("MuscleGroup");
var muscleGroup = Console.ReadLine();

Console.WriteLine("Sets");
int sets = Convert.ToInt32(Console.ReadLine());


Console.WriteLine("Repetitions");
var repetitions = Convert.ToInt16(Console.ReadLine());
Console.WriteLine("Description");
var descripion = Console.ReadLine();


var exercise = new Exercise()
{
    Name = name,
    MuscleGroup = muscleGroup,
    Sets = sets,
    Repetitions = repetitions,
    Description = descripion
};

db.Exercises.Add(exercise);
db.SaveChanges();
Console.WriteLine(exercise.Id);