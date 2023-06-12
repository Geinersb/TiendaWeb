using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using CapaDatos;
using CapaEntidad;

namespace CapaNegocio
{
   public class CN_Cliente
    {
        private CD_Cliente objCapaDato = new CD_Cliente();

        public List<Cliente> Listar()
        {
            return objCapaDato.Listar();
        }



        //METODO REGISTRAR CLIENTE
        public int Registrar(Cliente obj, out string Mensaje)
        {
            Mensaje = string.Empty;
            if (string.IsNullOrEmpty(obj.Nombre) || string.IsNullOrWhiteSpace(obj.Nombre))
            {
                Mensaje = "El nombre del cliente no puede ser vacio";
            }
            else if (string.IsNullOrEmpty(obj.Apellidos) || string.IsNullOrWhiteSpace(obj.Apellidos))
            {
                Mensaje = "El apellido del cliente no puede ser vacio";
            }
            else if (string.IsNullOrEmpty(obj.Correo) || string.IsNullOrWhiteSpace(obj.Correo))
            {
                Mensaje = "El correo del cliente no puede ser vacio";
            }


            if (string.IsNullOrEmpty(Mensaje))
            {
                //string clave = CN_Recursos.GenerarClave();

                //string asunto = "Creacion de Cuenta";
                //string mensaje_correo = "<h3> Su cuenta fue creada correctamente</h3></br><p>Su nueva clave para acceder es: !clave!</p>";
                //mensaje_correo = mensaje_correo.Replace("!clave!", clave);

                //bool respuesta = CN_Recursos.EnviarCorreo(obj.Correo, asunto, mensaje_correo);

                obj.Clave = CN_Recursos.ConvertirSha256(obj.Clave);
                return objCapaDato.Registrar(obj, out Mensaje);

                //if (respuesta)
                //{
                   
                //}
                //else
                //{
                //    Mensaje = "No se puede enviar el correo";
                //    return 0;

                //}

            }
            else
            {
                return 0;
            }


        }


        public bool CambiarClave(int idCliente, string nuevaClave, out string Mensaje)
        {
            return objCapaDato.CambiarClave(idCliente, nuevaClave, out Mensaje);
        }



        public bool RestablecerClave(int IdCliente, string Correo, out string Mensaje)
        {
            Mensaje = string.Empty;
            string nuevaClave = CN_Recursos.GenerarClave();
            bool resultado = objCapaDato.RestablecerClave(IdCliente, CN_Recursos.ConvertirSha256(nuevaClave), out Mensaje);

            if (resultado)
            {
                string asunto = "Contraseña Restablecida";
                string mensaje_correo = "<h3> Su cuenta fue restablecida correctamente</h3></br><p>Su nueva clave para acceder ahora es: !clave!</p>";
                mensaje_correo = mensaje_correo.Replace("!clave!", nuevaClave);

                bool respuesta = CN_Recursos.EnviarCorreo(Correo, asunto, mensaje_correo);


                if (respuesta)
                {
                    return true;
                }
                else
                {
                    Mensaje = "No se puede enviar el correo";
                    return false;

                }
            }

            else
            {
                Mensaje = "No se puede restablecer la clave";
                return false;
            }

        }





    }
}
