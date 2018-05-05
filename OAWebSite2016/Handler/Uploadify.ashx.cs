using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;

namespace TeacherWeb.Handler
{
    /// <summary>
    /// Uploadify 的摘要说明
    /// </summary>
    public class Uploadify : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Charset = "utf-8";

            HttpPostedFile file = context.Request.Files["Filedata"];
            string uploadPath = HttpContext.Current.Server.MapPath(@context.Request["folder"]) + "\\";

            if (file != null)
            {
                if (!Directory.Exists(uploadPath))
                {
                    Directory.CreateDirectory(uploadPath);
                }

                string originalFileName = file.FileName;
                string newFileName = Guid.NewGuid() + originalFileName.Substring(originalFileName.LastIndexOf("."));

                file.SaveAs(uploadPath + newFileName);

                //下面这句代码缺少的话，上传成功后上传队列的显示不会自动消失

                context.Response.Write(newFileName);
            }
            else
            {
                context.Response.Write("0");
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}
