namespace Web_DungCuHocTap.Models.Models
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class WebDungCuHocTapDbContext : DbContext
    {
        public WebDungCuHocTapDbContext()
            : base("name=WebDungCuHocTapDbContext")
        {
        }

        public virtual DbSet<Admin> Admins { get; set; }
        public virtual DbSet<CTHD> CTHDs { get; set; }
        public virtual DbSet<CTSP> CTSPs { get; set; }
        public virtual DbSet<HoaDon> HoaDons { get; set; }
        public virtual DbSet<KhachHang> KhachHangs { get; set; }
        public virtual DbSet<Mau> Maus { get; set; }
        public virtual DbSet<SanPham> SanPhams { get; set; }
        public virtual DbSet<TheLoai> TheLoais { get; set; }
        public virtual DbSet<TrangThai> TrangThais { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<HoaDon>()
                .Property(e => e.SDT)
                .IsUnicode(false);

            modelBuilder.Entity<HoaDon>()
                .HasMany(e => e.CTHDs)
                .WithOptional(e => e.HoaDon)
                .WillCascadeOnDelete();

            modelBuilder.Entity<KhachHang>()
                .HasMany(e => e.HoaDons)
                .WithOptional(e => e.KhachHang)
                .WillCascadeOnDelete();

            modelBuilder.Entity<Mau>()
                .HasMany(e => e.CTHDs)
                .WithOptional(e => e.Mau)
                .WillCascadeOnDelete();

            modelBuilder.Entity<Mau>()
                .HasMany(e => e.CTSPs)
                .WithOptional(e => e.Mau)
                .WillCascadeOnDelete();

            modelBuilder.Entity<SanPham>()
                .Property(e => e.GiaSP)
                .HasPrecision(18, 0);

            modelBuilder.Entity<SanPham>()
                .Property(e => e.KhuyenMai)
                .HasPrecision(18, 0);

            modelBuilder.Entity<SanPham>()
                .HasMany(e => e.CTHDs)
                .WithOptional(e => e.SanPham)
                .WillCascadeOnDelete();

            modelBuilder.Entity<SanPham>()
                .HasMany(e => e.CTSPs)
                .WithOptional(e => e.SanPham)
                .WillCascadeOnDelete();

            modelBuilder.Entity<TheLoai>()
                .HasMany(e => e.SanPhams)
                .WithOptional(e => e.TheLoai)
                .WillCascadeOnDelete();

            modelBuilder.Entity<TrangThai>()
                .HasMany(e => e.HoaDons)
                .WithOptional(e => e.TrangThai)
                .WillCascadeOnDelete();
        }
    }
}
