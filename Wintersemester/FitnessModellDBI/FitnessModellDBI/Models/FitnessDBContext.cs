﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace FitnessModellDBI.Models
{
    public partial class FitnessDBContext : DbContext
    {
        public FitnessDBContext()
        {
        }

        public FitnessDBContext(DbContextOptions<FitnessDBContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Exercise> Exercises { get; set; }
        public virtual DbSet<Membership> Memberships { get; set; }
        public virtual DbSet<Trainer> Trainers { get; set; }
        public virtual DbSet<User> Users { get; set; }
        public virtual DbSet<Workout> Workouts { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Data Source=127.0.0.1;Initial Catalog=FitnessDB;TrustServerCertificate=True;Persist Security Info=True;User ID=sa;Password=SqlServer2019");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>(entity =>
            {
                entity.HasOne(d => d.Membership)
                    .WithMany(p => p.Users)
                    .HasForeignKey(d => d.MembershipId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__User__Membership__03F0984C");

                entity.HasOne(d => d.Trainer)
                    .WithMany(p => p.Users)
                    .HasForeignKey(d => d.TrainerId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__User__TrainerId__02FC7413");

                entity.HasMany(d => d.Workouts)
                    .WithMany(p => p.Users)
                    .UsingEntity<Dictionary<string, object>>(
                        "UserWorkout",
                        l => l.HasOne<Workout>().WithMany().HasForeignKey("WorkoutId").OnDelete(DeleteBehavior.ClientSetNull).HasConstraintName("FK__UserWorko__Worko__0C85DE4D"),
                        r => r.HasOne<User>().WithMany().HasForeignKey("UserId").OnDelete(DeleteBehavior.ClientSetNull).HasConstraintName("FK__UserWorko__UserI__0B91BA14"),
                        j =>
                        {
                            j.HasKey("UserId", "WorkoutId").HasName("PK__UserWork__19948EEC6CD737A8");

                            j.ToTable("UserWorkout");
                        });
            });

            modelBuilder.Entity<Workout>(entity =>
            {
                entity.HasOne(d => d.Exercises)
                    .WithMany(p => p.Workouts)
                    .HasForeignKey(d => d.ExercisesId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Workout__Exercis__08B54D69");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}