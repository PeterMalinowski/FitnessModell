﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace FitnessModellDBI.Models
{
    public partial class Exercise
    {
        public Exercise()
        {
            Workouts = new HashSet<Workout>();
        }

        [Key]
        public int Id { get; set; }
        [Required]
        [StringLength(255)]
        [Unicode(false)]
        public string Name { get; set; }
        [Required]
        [StringLength(255)]
        [Unicode(false)]
        public string MuscleGroup { get; set; }
        public int Sets { get; set; }
        public int Repetitions { get; set; }
        [StringLength(255)]
        [Unicode(false)]
        public string Description { get; set; }

        [InverseProperty("Exercises")]
        public virtual ICollection<Workout> Workouts { get; set; }
    }
}