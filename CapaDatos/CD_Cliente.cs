﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using CapaEntidad;

namespace CapaDatos
{
    public class CD_Cliente
    {
        public List<Cliente> Listar()
        {
            List<Cliente> lista = new List<Cliente>();

            try
            {

                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    string query = "Select IdCliente,Nombre,Apellidos,Correo,Clave,Restablecer from Cliente";

                    SqlCommand cmd = new SqlCommand(query, oconexion);

                    cmd.CommandType = CommandType.Text;

                    oconexion.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            lista.Add(
                                new Cliente()
                                {
                                    IdCliente = Convert.ToInt32(dr["IdCliente"]),
                                    Nombre = dr["Nombre"].ToString(),
                                    Apellidos = dr["Apellidos"].ToString(),
                                    Correo = dr["Correo"].ToString(),
                                    Clave = dr["Clave"].ToString(),
                                    Restablecer = Convert.ToBoolean(dr["Restablecer"]),
                                    

                                }

                                );
                        }
                    }
                }
            }
            catch (Exception)
            {
                lista = new List<Cliente>();
                //throw;
            }

            return lista;
        }




        public int Registrar(Cliente obj, out string Mensaje)
        {
            int idautogenerado = 0;
            Mensaje = string.Empty;

            try
            {
                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("SP_RegistrarCliente", oconexion);
                    cmd.Parameters.AddWithValue("Nombre", obj.Nombre);
                    cmd.Parameters.AddWithValue("Apellidos", obj.Apellidos);
                    cmd.Parameters.AddWithValue("Correo", obj.Correo);
                    cmd.Parameters.AddWithValue("Clave", obj.Clave);
                    cmd.Parameters.Add("Resultado", SqlDbType.Int).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("Mensaje", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;

                    oconexion.Open();

                    cmd.ExecuteNonQuery();

                    idautogenerado = Convert.ToInt32(cmd.Parameters["Resultado"].Value);
                    Mensaje = cmd.Parameters["Mensaje"].Value.ToString();

                }
            }
            catch (Exception ex)
            {
                idautogenerado = 0;
                Mensaje = ex.Message;
            }

            return idautogenerado;

        }




        public bool CambiarClave(int idCliente, string nuevaClave, out string Mensaje)
        {
            bool resultado = false;
            Mensaje = string.Empty;

            try
            {
                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("update Cliente set clave = @nuevaclave, restablecer = 0 where IdCliente = @id", oconexion);
                    cmd.Parameters.AddWithValue("@id", idCliente);
                    cmd.Parameters.AddWithValue("@nuevaClave", nuevaClave);
                    cmd.CommandType = CommandType.Text;
                    oconexion.Open();
                    resultado = cmd.ExecuteNonQuery() > 0 ? true : false;

                }
            }
            catch (Exception ex)
            {
                resultado = false;
                Mensaje = ex.Message;

            }
            return resultado;

        }




        public bool RestablecerClave(int idCliente, string Clave, out string Mensaje)
        {
            bool resultado = false;
            Mensaje = string.Empty;

            try
            {
                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("Update Cliente set clave = @Clave, restablecer = 1 where IdCliente = @id", oconexion);
                    cmd.Parameters.AddWithValue("@id", idCliente);
                    cmd.Parameters.AddWithValue("@Clave", Clave);
                    cmd.CommandType = CommandType.Text;
                    oconexion.Open();
                    resultado = cmd.ExecuteNonQuery() > 0 ? true : false;

                }
            }
            catch (Exception ex)
            {
                resultado = false;
                Mensaje = ex.Message;

            }
            return resultado;

        }




    }

}
