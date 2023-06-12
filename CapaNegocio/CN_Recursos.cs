﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Net.Mail;
using System.Net;
using System.IO;

namespace CapaNegocio
{
   public class CN_Recursos
    {
        //encriptaci[on de Texto en SHA256
        public static string ConvertirSha256(string texto)
        {
            StringBuilder sb = new StringBuilder();
            //Se pone referencia security cryptography 
            using(SHA256 hash = SHA256Managed.Create())
            {
                Encoding enc = Encoding.UTF8;
                byte[] result = hash.ComputeHash(enc.GetBytes(texto));

                foreach (byte b in result)
                {
                    sb.Append(b.ToString("x2"));
                }

                return sb.ToString();
            }
        }


        //METODO PARA GENERAR CLAVE ALEATORIA DE 6 DIGITOS
        public static string GenerarClave()
        {
            string clave = Guid.NewGuid().ToString("N").Substring(0, 6);
            return clave;

        }

        //metodo para enviar correo 
        public static bool EnviarCorreo(string correo, string asunto, string mensaje)
        {
            bool resultado = false;

            try
            {

                MailMessage mail = new MailMessage();
                mail.To.Add(correo);
                mail.From = new MailAddress("geinersbweb@gmail.com");
                mail.Subject = asunto;
                mail.Body = mensaje;
                mail.IsBodyHtml = true;

                var smtp = new SmtpClient()
                {
                    Credentials = new NetworkCredential("geinersbweb@gmail.com", "lrrojvaxwatudrwb"),
                    Host = "smtp.gmail.com",
                    Port = 587,
                    EnableSsl=true
                };

                smtp.Send(mail);
                resultado = true;
            }
            catch (Exception ex)
            {
                resultado = false;

            }

            return resultado;

        }


        public static string ConvertirBase64(string ruta,out bool conversion)
        {
            string textoBase64 = string.Empty;
            conversion = true;

            try
            {
                byte[] bytes = File.ReadAllBytes(ruta);
                textoBase64 = Convert.ToBase64String(bytes);
            }
            catch (Exception)
            {
                conversion = false;
                
            }
            return textoBase64;
        }











    }
}
