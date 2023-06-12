using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaEntidad;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace CapaDatos
{
    public class CD_Ubicacion
    {
        public List<Provincia> ObtenerProvincia()
        {
            List<Provincia> lista = new List<Provincia>();

            try
            {

                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    string query = "select * from PROVINCIA";

                    SqlCommand cmd = new SqlCommand(query, oconexion);

                    cmd.CommandType = CommandType.Text;

                    oconexion.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            lista.Add(
                                new Provincia()
                                {
                                    IdProvincia = dr["IdProvincia"].ToString(),
                                    Descripcion = dr["Descripcion"].ToString(),
                                   

                                }

                                );
                        }
                    }
                }
            }
            catch (Exception)
            {
                lista = new List<Provincia>();
                throw;
            }

            return lista;
        }



        public List<Canton> ObtenerCanton(string IdProvincia)
        {
            List<Canton> lista = new List<Canton>();

            try
            {

                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    string query = "select * from CANTON  WHERE IdProvincia = @IdProvincia";                   

                    SqlCommand cmd = new SqlCommand(query, oconexion);

                    cmd.Parameters.AddWithValue("@IdProvincia", IdProvincia);

                    cmd.CommandType = CommandType.Text;

                    oconexion.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            lista.Add(
                                new Canton()
                                {
                                    IdCanton = dr["IdCanton"].ToString(),
                                    Descripcion = dr["Descripcion"].ToString(),


                                }

                                );
                        }
                    }
                }
            }
            catch (Exception)
            {
                lista = new List<Canton>();
              
            }

            return lista;
        }


        public List<Distrito> ObtenerDistrito(string IdCanton, string IdProvincia)
        {
            List<Distrito> lista = new List<Distrito>();

            try
            {

                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    string query = "select * from DISTRITO WHERE IdCanton = @IdCanton AND IdProvincia = @idProvincia";

                    SqlCommand cmd = new SqlCommand(query, oconexion);

                    cmd.Parameters.AddWithValue("@IdCanton", IdCanton);
                    cmd.Parameters.AddWithValue("@IdProvincia", IdProvincia);

                    cmd.CommandType = CommandType.Text;

                    oconexion.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            lista.Add(
                                new Distrito()
                                {
                                    IdDistrito = dr["IdDistrito"].ToString(),
                                    Descripcion = dr["Descripcion"].ToString(),


                                }

                                );
                        }
                    }
                }
            }
            catch (Exception)
            {
                lista = new List<Distrito>();
                throw;
            }

            return lista;
        }

    }
}
