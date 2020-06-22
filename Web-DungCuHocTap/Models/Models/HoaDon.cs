namespace Web_DungCuHocTap.Models.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("HoaDon")]
    public partial class HoaDon
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public HoaDon()
        {
            CTHDs = new HashSet<CTHD>();
        }

        [Key]
        public int MaHD { get; set; }

        public DateTime? NgayTao { get; set; }

        [StringLength(255)]
        public string TenKH { get; set; }

        [StringLength(15)]
        public string SDT { get; set; }

        public string DiaChi { get; set; }

        public decimal? TongTien { get; set; }

        public int? MaKH { get; set; }

        public int? MaTT { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CTHD> CTHDs { get; set; }

        public virtual KhachHang KhachHang { get; set; }

        public virtual TrangThai TrangThai { get; set; }
    }
}
