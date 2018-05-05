using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Windows.Forms;
using WebFrame;
using WebFrame.Util;
using System.Web;
using System.Web.Script.Serialization;
using System.Collections;
using System.IO;

namespace KORWeb.BUL
{
   public class UTools
    {
       /// <summary>
       /// 清除缓存
       /// </summary>
       public static void ClearCache()
       {
            System.Web.HttpContext.Current.Response.Expires =-1;
            System.Web.HttpContext.Current.Response.ExpiresAbsolute=DateTime.Now.AddSeconds(-1);
            System.Web.HttpContext.Current.Response.CacheControl = "no-cache";
       }

       /// <summary>
       /// 清除浏览器的缓存
       /// </summary>
       public static void ClearAshxCache(HttpContext context)
       {
           //清除浏览器的缓存
           context.Response.Cache.SetNoStore();

       }


       //提示和聚焦控件
       public static void AlertAndFocusControl(String info, String ClientID)
       {
           String js1 = "layer.alert('{0}');";
           js1 = js1 + "$('#{1}').focus();";
           JAjax.ExecuteJS(String.Format(js1, info, ClientID));
       }

       //提示
       public static void Alert(String info)
       {
           String js1 = "layer.alert('{0}');";
           JAjax.ExecuteJS(String.Format(js1, info));
       }


       /*
            得到EasyUi的Tree 数据
            DataTable 的列结构
            id 唯一
            text 
            parentid 如果没有parentid 则设置为空
            state   如果需要关闭，则设置为closed
            checked 如果需要选择，则设置为true （布尔型）
        */

       /// <summary>
       /// </summary>
       /// <param name="ds"></param>
       /// <returns></returns>
       public static String GetEasyUiTreeData(DataTable dt)
       {
           String str1=AddNode(dt,"", 1);
           return str1;
       }


       /// <summary>
       /// 利用递归生产EasyUI所需要的JSon的数据
       /// </summary>
       /// <param name="ds"></param>
       /// <param name="ParentID"></param>
       /// <param name="deep"></param>
       /// <returns></returns>
       private static string AddNode(DataTable dt,
           string ParentID, int deep)
       {
           string str = "";
           DataView dvTree = new DataView(dt);
           if (String.IsNullOrEmpty(ParentID) == false)
           {
               dvTree.RowFilter = "[parentid] ='" + ParentID + "'";//过滤出ParentId
           }
           else
           {
               dvTree.RowFilter = "[parentid] is null";//过滤出ParentId
           }

           bool hasState = false;
           if (dt.Columns.Contains("state"))
           {
               hasState = true;
           }

           bool hasChecked = false;
           if (dt.Columns.Contains("checked"))
           {
               hasChecked = true;
           }

           bool hasTag = false;
           if (dt.Columns.Contains("tag"))
           {
               hasTag = true;
           }

           int i = 0;
           int d = deep;
           foreach (DataRowView drv in dvTree)
           {
               if (i == 0)//如果是某一层的开始，需要“[”开始
               {
                   if (d == 1)//如果深度为1,即第一层
                       str = "[";
                   else//否则，为第二层或更深
                       str = ",\"children\":[";
               }
               else
                   str = str + ",";

               str = str + "{";
               str = str + "\"ID\":\"" + drv["id"] + "\",";
               str = str + "\"text\":\"" + drv["text"] + "\"";

               //处理state
               
               if (hasState)
               {
                   if (String.IsNullOrEmpty(drv["state"].ToString()) == false)
                   {
                       str = str + ",\"state\":\"" + drv["state"].ToString() + "\"";
                   }
               }

               //处理checked
               if (hasChecked)
               {
                   if (String.IsNullOrEmpty(drv["checked"].ToString()) == false)
                   {
                       str = str + ",\"checked\":" + drv["checked"].ToString() + "";
                   }
               }

               //处理tag (用户自定义数据)
               if (hasTag)
               {
                   if (String.IsNullOrEmpty(drv["tag"].ToString()) == false)
                   {
                       str = str + ",\"tag\":\"" + drv["tag"].ToString() + "\"";
                   }
               }


               str = str + AddNode(dt,drv["id"].ToString(), deep + 1);//递归
               str = str + "}";
               i = i + 1;
               if (dvTree.Count == i)//如果某一层到了末尾,需要"]"结束
                   str = str + "]";
           }
           return str;
       }


       public static string DataTableToJson(DataTable dt)
       {
           JavaScriptSerializer javaScriptSerializer = new JavaScriptSerializer();
           javaScriptSerializer.MaxJsonLength = Int32.MaxValue; //取得最大数值
           ArrayList arrayList = new ArrayList();
           foreach (DataRow dataRow in dt.Rows)
           {
               Dictionary<string, object> dictionary = new Dictionary<string, object>();  //实例化一个参数集合
               foreach (DataColumn dataColumn in dt.Columns)
               {
                   dictionary.Add(dataColumn.ColumnName, dataRow[dataColumn.ColumnName].ToString());
               }
               arrayList.Add(dictionary); //ArrayList集合中添加键值
           }

           return javaScriptSerializer.Serialize(arrayList);  //返回一个json字符串
       }

       public static DataTable JsonToDataTable(string json)
       {
           DataTable dataTable = new DataTable();  //实例化
           DataTable result;
           try
           {
               JavaScriptSerializer javaScriptSerializer = new JavaScriptSerializer();
               javaScriptSerializer.MaxJsonLength = Int32.MaxValue; //取得最大数值
               ArrayList arrayList = javaScriptSerializer.Deserialize<ArrayList>(json);
               if (arrayList.Count > 0)
               {
                   foreach (Dictionary<string, object> dictionary in arrayList)
                   {
                       if (dictionary.Keys.Count<string>() == 0)
                       {
                           result = dataTable;
                           return result;
                       }
                       if (dataTable.Columns.Count == 0)
                       {
                           foreach (string current in dictionary.Keys)
                           {
                               dataTable.Columns.Add(current, dictionary[current].GetType());
                           }
                       }
                       DataRow dataRow = dataTable.NewRow();
                       foreach (string current in dictionary.Keys)
                       {
                           dataRow[current] = dictionary[current];
                       }

                       dataTable.Rows.Add(dataRow); //循环添加行到DataTable中
                   }
               }
           }
           catch
           {
           }
           result = dataTable;
           return result;
       }


       /// <summary>
       /// 将客户端的文件上传到服务器
       /// </summary>
       /// <param name="clientFileName"></param>
       /// <returns></returns>
       public static String SaveFileToServer(System.Web.UI.WebControls.FileUpload file1)
       {
           String result = String.Empty;
           try
           {
               if (file1.HasFile)
               {
                   String clientFileName = file1.FileName;
                   String dir1 = "/Attachment/UseAttachment/";

                   HttpServerUtility server1 = System.Web.HttpContext.Current.Server;
                   if (Directory.Exists(server1.MapPath(dir1)) == false)
                   {
                       Directory.CreateDirectory(server1.MapPath(dir1));
                   }
                   String ext = Path.GetExtension(clientFileName);
                   dir1 = dir1 + JString.GetUnique32ID() + ext;

                   file1.SaveAs(server1.MapPath(dir1));
                   result = dir1;
               }
           }
           catch (Exception err)
           {
               result = String.Empty;
           }
           return result;
       }
    }
}
