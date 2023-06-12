using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaEntidad;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Globalization;

namespace CapaDatos
{
    public class CD_Reporte
    {

        public List<Reporte> Ventas(string FechaInicio, string FechaFin, string IdTransaccion)
        {
            List<Reporte> lista = new List<Reporte>();

            try
            {

                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                   

                    SqlCommand cmd = new SqlCommand("SP_ReporteVentas", oconexion);
                    cmd.Parameters.AddWithValue("FechaInicio", FechaInicio);
                    cmd.Parameters.AddWithValue("FechaFin", FechaFin);
                    cmd.Parameters.AddWithValue("IdTransaccion", IdTransaccion);

                    cmd.CommandType = CommandType.StoredProcedure;

                    oconexion.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            lista.Add(
                                new Reporte()
                                {
                                    FechaVenta = dr["FechaVenta"].ToString(),
                                    Cliente = dr["Cliente"].ToString(),
                                    Producto = dr["Producto"].ToString(),
                                    Precio = Convert.ToDecimal( dr["Precio"], new CultureInfo("es-CR")),
                                    Cantidad = Convert.ToInt32( dr["Cantidad"].ToString()),
                                    Total = Convert.ToDecimal(dr["Total"], new CultureInfo("es-CR")),
                                    IdTransaccion = dr["IdTransaccion"].ToString()

                                }

                                );
                        }
                    }
                }
            }
            catch (Exception)
            {
                lista = new List<Reporte>();
                throw;
            }

            return lista;
        }






        public Dashboard VerDashboard()
        {
            Dashboard objeto = new Dashboard();

            try
            {

                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                  

                    SqlCommand cmd = new SqlCommand("SP_ReporteDashboard", oconexion);

                    cmd.CommandType = CommandType.StoredProcedure;

                    oconexion.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            objeto = new Dashboard()
                            {
                                TotalCliente= Convert.ToInt32(dr["TotalCliente"]),
                                TotalVenta = Convert.ToInt32(dr["TotalVenta"]),
                                TotalProducto = Convert.ToInt32(dr["TotalProducto"])                            };
                        }
                    }
                }
            }
            catch (Exception)
            {
                objeto = new Dashboard();
            }

            return objeto;
        }

    }
}
