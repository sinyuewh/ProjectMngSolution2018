using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using WebFrame.Data;
using WebFrame.Util;
using System.IO;
using WebFrame;

namespace OAWebSite.Controls
{
    public partial class AttachmentControl : System.Web.UI.UserControl
    {
        #region 相关属性设置
        /// <summary>
        /// 相关表的名字
        /// </summary>
        public String TableName
        {
            get
            {
                if (ViewState["TableName"] == null)
                {
                    return "JAttachment";
                }
                else
                {
                    return ViewState["TableName"].ToString();
                }
            }
            set
            {
                ViewState["TableName"] = value;
            }
        }

        /// <summary>
        /// 相关字段的名字
        /// </summary>
        public String ParentField
        {
            get
            {
                if (ViewState["ParentField"] == null)
                {
                    return "PARENTGUID";
                }
                else
                {
                    return ViewState["ParentField"].ToString();
                }
            }
            set
            {
                ViewState["ParentField"] = value;
            }
        }

        /// <summary>
        /// 附件存放的目录
        /// </summary>
        public String AttachmentPath
        {
            get
            {
                if (ViewState["AttachmentPath"] == null)
                {
                    return "/Attachment/UseAttachment/";
                }
                else
                {
                    return ViewState["AttachmentPath"].ToString();
                }
            }
            set
            {
                ViewState["AttachmentPath"] = value;
            }
        }


        /// <summary>
        /// 是否能修改附件
        /// </summary>
        public bool ReadOnly
        {
            get
            {
                if (ViewState["ReadOnly"] == null)
                {
                    return false;
                }
                else
                {
                    return (bool)ViewState["ReadOnly"];
                }
            }
            set
            {
                ViewState["ReadOnly"] = value;
            }
        }

        /// <summary>
        /// 附件列表的排序条件
        /// </summary>
        public String OrderBy
        {
            get
            {
                if (ViewState["OrderBy"] == null)
                {
                    return "UPLOADTIME";
                }
                else
                {
                    return ViewState["OrderBy"].ToString();
                }
            }
            set
            {
                ViewState["OrderBy"] = value;
            }
        }

        /// <summary>
        /// 相关数据
        /// </summary>
        public String ParentID
        {
            get
            {
                if (ViewState["KeyID"] == null)
                {
                    return "-1";
                }
                else
                {
                    return ViewState["KeyID"].ToString();
                }
            }
            set
            {
                ViewState["KeyID"] = value;
            }
        }

        /// <summary>
        /// 文件控件的长度
        /// </summary>
        public String FileWidth
        {
            get
            {
                if (ViewState["FileWidth"] == null)
                {
                    return String.Empty;
                }
                else
                {
                    return ViewState["FileWidth"].ToString();
                }
            }
            set
            {
                ViewState["FileWidth"] = value;
            }
        }


        /// <summary>
        /// 设置文件后缀过滤器
        /// </summary>
        public string FileFilter
        {
            get { return this.file.FileFilter; }
            set { this.file.FileFilter = value; }
        }

        /// <summary>
        /// 设置单个文件上传的最小尺寸
        /// </summary>
        public int MinFileSize
        {
            get { return this.file.MinFileSize; }
            set { this.file.MinFileSize = value; }
        }

        /// <summary>
        /// 设置单个文件上传的最大尺寸
        /// </summary>
        public int MaxFileSize
        {
            get { return this.file.MaxFileSize; }
            set { this.file.MaxFileSize = value; }
        }

        /// <summary>
        /// 得到附件列表的数据
        /// </summary>
        public DataTable AttachmentList
        {
            get
            {
                if (ViewState["AttachmentList"] == null)
                {
                    throw new Exception("错误：没有正确的调用BindDataFromDB方法！");
                }
                else
                {
                    return (DataTable)ViewState["AttachmentList"];
                }
            }
            set
            {
                ViewState["AttachmentList"] = value;
            }
        }
        #endregion

        /// <summary>
        /// 从数据库中绑定数据
        /// </summary>
        public void BindDataFromDB()
        {
            DataTable dt1 = null;
            JTable tab1 = new JTable(this.TableName);
            if (String.IsNullOrEmpty(this.ParentID) == false)
            {
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField(this.ParentField, this.ParentID));
                condition.Add(new SearchField("DEL", "0", SearchFieldType.NumericType));

                tab1.OrderBy = this.OrderBy;
                dt1 = tab1.SearchData(condition, -1, "*").Tables[0];
            }
            tab1.Close();

            //增加数据的标识状态
            dt1.Columns.Add("DataStatus");
            dt1.PrimaryKey = new DataColumn[] { dt1.Columns["GUIDID"] };
           
            //将数据保存到视图状态
            this.AttachmentList = dt1;

            //绑定List显示的数据
            this.BindList();
        }

        /// <summary>
        /// 将视图状态中的数据进行提交
        /// 1、判断是否有删除的数据，如果有，则删除
        /// 2、判断是否有新增的数据，如果有，则新增
        /// 3、剔除PARENTGUID为-1的数据
        /// </summary>
        public void Submit()
        {
            DataTable dt1 = this.AttachmentList;
            JTable tab1 = new JTable(this.TableName);
            List<SearchField> condition = new List<SearchField>();
            Dictionary<String, object> dic1 = new Dictionary<string, object>();
            foreach (DataRow dr1 in dt1.Rows)
            {
                if (dr1["PARENTGUID"].ToString() != "-1")
                {
                    if (dr1["DataStatus"].ToString() == "deletedata")  //需要删除数据
                    {
                        //删除文件
                        if (String.IsNullOrEmpty(dr1["FILEDIR"].ToString()) == false
                         && String.IsNullOrEmpty(dr1["ENCRYPTFILENAME"].ToString()) == false)
                        {
                            String fileName = dr1["FILEDIR"].ToString() + dr1["ENCRYPTFILENAME"].ToString();
                            fileName = Server.MapPath(fileName);
                            if (File.Exists(fileName))
                            {
                                File.Delete(fileName);
                            }
                        }

                        //删除数据库中的相关数据
                        condition.Clear();
                        condition.Add(new SearchField("GUIDID",dr1["GUIDID"].ToString()));
                        dic1.Clear();
                        dic1["DEL"] = "1";  //逻辑删除数据
                        tab1.EditData(dic1, condition);
                        //tab1.DeleteData(condition);
                    }

                    if (dr1["DataStatus"].ToString() == "newdata")  //表示新增数据
                    {
                        //将文件名改名，去掉$$符号
                        if (String.IsNullOrEmpty(dr1["FILEDIR"].ToString()) == false
                         && String.IsNullOrEmpty(dr1["ENCRYPTFILENAME"].ToString()) == false)
                        {
                            String fileName = dr1["FILEDIR"].ToString() + dr1["ENCRYPTFILENAME"].ToString();
                            String fileName1 = dr1["FILEDIR"].ToString() + dr1["ENCRYPTFILENAME"].ToString().Replace("$$","");
                            fileName = Server.MapPath(fileName);
                            fileName1=Server.MapPath(fileName1);

                            File.Copy(fileName, fileName1);
                            File.Delete(fileName);
                        }

                        //更新数据中的数据
                        dic1.Clear();
                        dic1=FrameLib.GetDictionaryByDataRow(dr1);
                        dic1["ENCRYPTFILENAME"] = dic1["ENCRYPTFILENAME"].ToString().Replace("$$", "");
                        dic1.Remove("DataStatus");
                        tab1.InsertData(dic1);
                    }
                }
            }
            tab1.Close();
        }

        protected override void OnInit(EventArgs e)
        {
            this.but1.Click += new EventHandler(but1_Click);
            this.data1.ItemCommand += new DataListCommandEventHandler(data1_ItemCommand);
            this.data1.ItemDataBound += new DataListItemEventHandler(data1_ItemDataBound);
            base.OnInit(e);
        }

        void data1_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            if (this.ReadOnly)
            {
                LinkButton link1 = e.Item.FindControl("butDel") as LinkButton;
                if (link1 != null)
                {
                    link1.Visible = false;
                }
            }
        }

        //删除附件数据
        void data1_ItemCommand(object source, DataListCommandEventArgs e)
        {
             Label lab0 = e.Item.FindControl("lab1") as Label;

            //删除视图状态中的数据
            if (lab0.Text != String.Empty)
            {
                DataTable dt1 = this.AttachmentList;
                DataRow dr1= dt1.Rows.Find(lab0.Text);
                if (dr1 != null)
                {
                    dr1["DataStatus"] = "deletedata";       //将数据设置为删除标识
                }
                this.AttachmentList = dt1;
                
                //重新绑定数据
                this.BindList();
            }
        }

        //增加新的上传文件
        void but1_Click(object sender, EventArgs e)
        {
            if (file.HasFile)
            {
                if (file.CheckData())
                {
                    String dir1 = HttpContext.Current.Server.MapPath(this.AttachmentPath);
                    //如果路径不存在，则创建
                    if (System.IO.Directory.Exists(dir1) == false)
                    {
                        System.IO.Directory.CreateDirectory(dir1);
                    }
                    String trueName = Path.GetFileName(file.FileName);
                    DateTime dt = DateTime.Now;
                    string picfileName = "$$"+dt.Year + "" + dt.Month + "" + dt.Day + "" + dt.Hour + "" + dt.Minute + "" + dt.Second + "" + dt.Millisecond + Path.GetExtension(trueName);
                    //组合路径，file.GetName()取得文件名
                    dir1 = dir1 + "/" + picfileName;
                    file.SaveAs(dir1);

                    //将数据保存到视图状态
                    DataTable dt1 = this.AttachmentList;
                    DataRow dr1 = dt1.NewRow();

                    dr1["GUIDID"] = Guid.NewGuid().ToString();
                    dr1["PARENTGUID"] = this.ParentID;
                    dr1["FILENAME"] = trueName;
                    dr1["ENCRYPTFILENAME"] = picfileName;
                    dr1["UPLOADTIME"] = DateTime.Now;
                    dr1["UPLOADPERSON"] = FrameLib.UserID;
                    dr1["FILEDIR"] = this.AttachmentPath;
                    dr1["Describle"] = txtFileDesc.Text; //附件描述
                    String ext1 = Path.GetExtension(trueName).ToLower();
                    if (ext1 == ".bmp" || ext1 == ".gif" || ext1 == ".png" || ext1 == ".jpg" || ext1 == ".jpeg")
                    {
                        dr1["Kind"] = "0";
                    }
                    dr1["DataStatus"] = "newdata";  //表示是新数据（提交时需要进一步处理）
                    dr1["DEL"] = "0";
                    dt1.Rows.Add(dr1);
                    this.AttachmentList = dt1;      //重新保存到视图状态

                    //绑定List显示的数据
                    this.BindList();
                }
                else
                {
                    JAjax.Alert(this.file.ErrorInfo);
                }
            }
            else
            {
                JAjax.Alert("提示：请选择一个要上传的文件！");
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (String.IsNullOrEmpty(this.FileWidth) == false)
                {
                    this.file.Width = Unit.Parse(this.FileWidth);
                }

                if (FrameLib.AuthorityID == "A3")
                {
                    this.ReadOnly = true;
                }

                if (this.ReadOnly)
                {
                    this.div1.Visible = false;
                }
            }
        }

        /// <summary>
        /// 绑定List的数据
        /// </summary>
        private void BindList()
        {
            DataTable dt1 = this.AttachmentList;
            DataView dv1 = dt1.DefaultView;
            dv1.RowFilter = "DataStatus is null or DataStatus<>'deletedata'";   //去掉删除的数据
            this.data1.DataSource = dv1;
            this.data1.DataBind();
        }
    }
}