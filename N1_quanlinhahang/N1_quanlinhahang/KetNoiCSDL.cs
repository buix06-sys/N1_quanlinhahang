using System;
using System.Data;
using System.Data.SqlClient;

namespace N1_quanlinhahang
{
    public class KetNoiCSDL
    {
        // Chuỗi kết nối SQL Server 2012 Express
        private string strConn = @"Data Source=.\SQLEXPRESS;Initial Catalog=QL_NhaHang_Moi;Integrated Security=True";

        public SqlConnection LayKetNoi()
        {
            SqlConnection conn = new SqlConnection(strConn);
            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();
            }
            return conn;
        }

        // Phương thức thực thi truy vấn lấy dữ liệu (SELECT)
        public DataTable ExecuteQuery(string query)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = LayKetNoi())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
            return dt;
        }

        // Phương thức thực thi thêm, sửa, xóa (INSERT, UPDATE, DELETE)
        public int ExecuteNonQuery(string query)
        {
            int rowsAffected = 0;
            using (SqlConnection conn = LayKetNoi())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    rowsAffected = cmd.ExecuteNonQuery();
                }
            }
            return rowsAffected;
        }
    }
}