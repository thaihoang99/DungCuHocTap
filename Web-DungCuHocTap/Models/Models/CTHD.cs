namespace Web_DungCuHocTap.Models.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("CTHD")]
    public partial class CTHD
    {
        [Key]
        public int MaCTHD { get; set; }

        public int? SoLuong { get; set; }

        public int? MaHD { get; set; }

        public int? MaSP { get; set; }

        public int? MaMau { get; set; }

        public virtual HoaDon HoaDon { get; set; }

        public virtual Mau Mau { get; set; }

        public virtual SanPham SanPham { get; set; }
    }
}
