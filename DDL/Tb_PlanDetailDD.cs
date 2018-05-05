using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WebFrame;
using WebFrame.Data;

namespace KORWeb.DDL
{
    /// <summary>
    /// 说明：Tb_Task
    /// 编码：王松
    /// 时间：2016/8/11 17:28:13
    /// </summary>
    [Serializable]
    public class Tb_PlanDetailDD : DataEntityBase
    {
        //实体属性
        public String PlanKind { get; set; }
        public String PlanNum { get; set; }
        public String PlanTitel { get; set; }
        public String PlanID { get; set; }
        public String ParentGuid { get; set; }
        public DateTime? BegTime { get; set; }
        public DateTime? EndTime { get; set; }
        public double? Workload { get; set; }
        public double? ValidWork { get; set; }
        public bool? KeyPlan { get; set; }
        public String ExecuteManID { get; set; }
        public String ExecuteManName { get; set; }
        public int? FinishFlag { get; set; }

        public DateTime? FinishDate { get; set; }
        public String Remark { get; set; }
        public String PayMemo { get; set; }

        //用于月计划
        public String ParentNum { get; set; }
        public String MaonthPlanNum { get; set; }

    }
}