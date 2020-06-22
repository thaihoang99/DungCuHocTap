using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using Web_DungCuHocTap.Models;
using Web_DungCuHocTap.Models.Models;

namespace Web_DungCuHocTap.Controllers
{
    public class CustomerController : Controller
    {
        //[Route("SignUp")]
        public ActionResult DangKyDangNhap()
        {
            return View();
        }

        [HttpPost]
        public JsonResult DangKy(KhachHang model)
        {
            if (ModelState.IsValid)
            {
                model.UserPassword = MD5Hash(model.UserPassword);
                model.NgayTao = DateTime.Now;

                var db = new WebDungCuHocTapDbContext();
                db.KhachHangs.Add(model);
                db.SaveChanges();

                return Json(new { Success = 1 }, JsonRequestBehavior.AllowGet);
            }
            return Json(new { Success = 0 }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult DangNhap(LoginModel model)
        {
            string enc = MD5Hash(model.UserPassword);
            var result = new WebDungCuHocTapDbContext().KhachHangs.Count(x => x.UserName == model.UserName && x.UserPassword == enc);

            if (ModelState.IsValid && result > 0)
            {
                FormsAuthentication.SetAuthCookie(model.UserName, true);

                return Json(1, JsonRequestBehavior.AllowGet);
            }
            return Json(0, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            Session["CartItem"] = null;
            return RedirectToAction("DangKyDangNhap", "Customer");
        }

        public static string MD5Hash(string input)
        {
            StringBuilder hash = new StringBuilder();
            MD5CryptoServiceProvider md5provider = new MD5CryptoServiceProvider();
            byte[] bytes = md5provider.ComputeHash(new UTF8Encoding().GetBytes(input));

            for (int i = 0; i < bytes.Length; i++)
            {
                hash.Append(bytes[i].ToString("x2"));
            }
            return hash.ToString();
        }
        [Authorize]

        public ActionResult Detail()
        {
            return View();
        }

        //form dang nhap-> dang ky cai form de authentication -> dang nhap thanh cong -> set cookie
    }
}