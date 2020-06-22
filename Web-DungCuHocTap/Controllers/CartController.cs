using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web_DungCuHocTap.Models;
using Web_DungCuHocTap.Models.Models;

namespace Web_DungCuHocTap.Controllers
{
    public class CartController : Controller
    {
        [Authorize]
        public ActionResult Cart()
        {
            return View();
        }

        [HttpGet]
        public JsonResult AddItem(int id, int quantity)
        {
            var item = new WebDungCuHocTapDbContext().SanPhams.Find(id);
            if (item == null)
            {
                return Json(0, JsonRequestBehavior.AllowGet);
            }
            if (Session["CartItem"] == null)
            {
                var cart = new List<CartModel>();
                cart.Add(new CartModel()
                {
                    SP = item,
                    Quantity = quantity
                });
                Session["CartItem"] = cart;
            }
            else
            {
                var index = CheckExist(id);
                var cart = Session["CartItem"] as List<CartModel>;
                if (index == -1)
                {
                    cart.Add(new CartModel()
                    {
                        SP = item,
                        Quantity = quantity
                    });
                }
                else
                    cart[index].Quantity += quantity;
            }
            return Json(1, JsonRequestBehavior.AllowGet);
        }

        public int CheckExist(int id)
        {
            //tim vi tri cua id trong gio hang
            var cart = Session["CartItem"] as List<CartModel>;
            for (int i = 0; i < cart.Count; i++)
            {
                if (cart[i].SP.MaSP == id)
                    return i;
            }
            return -1;
        }

        public void DeleteItem(int id, string url)
        {
            int index = CheckExist(id);
            var cart = Session["CartItem"] as List<CartModel>;
            cart.RemoveAt(index);
            if (cart.Count == 0)
            {
                Session["CartItem"] = null;
            }
            //return RedirectToAction("DanhSachSanPham", "Shop");
            Response.Redirect(url, true);
        }

        [Authorize]
        public JsonResult CheckOut(HoaDon model)
        {
            if (ModelState.IsValid)
            {
                model.NgayTao = DateTime.Now;
                //model.TongTien = 
                model.MaTT = 1;

                var db = new WebDungCuHocTapDbContext();
                db.HoaDons.Add(model);
                db.SaveChanges();

                return Json(new { Success = 1 }, JsonRequestBehavior.AllowGet);
            }
            return Json(new { Success = 0 }, JsonRequestBehavior.AllowGet);
        }
    }
}