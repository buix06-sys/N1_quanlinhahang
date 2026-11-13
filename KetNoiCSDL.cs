using System;
using System.Data;
using System.Data.SqlClient;

namespace N1_quanlinhahang
{
    public class KetNoiCSDL
    {
        // Chuỗi kết nối trực tiếp chuẩn xác với Server của bạn
        private string strCon = @"Data Source=ADMIN-PC\SQLEXPRESS;Initial Catalog=QL_NhaHang_Moi;Integrated Security=True";

        public SqlConnection LayKetNoi()
        {
            return new SqlConnection(strCon);
        }

        public DataTable LayDuLieu(string sql)
        {
            using (SqlConnection con = LayKetNoi())
            {
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        return dt;
                    }
                }
            }
        }

        public int ThucThiNonQuery(string sql)
        {
            using (SqlConnection con = LayKetNoi())
            {
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    con.Open();
                    return cmd.ExecuteNonQuery();
                }
            }
        }
    }
}