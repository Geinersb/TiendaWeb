using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaDatos;
using CapaEntidad;

namespace CapaNegocio
{
   public class CN_Ubicacion
    {
        private CD_Ubicacion objCapaDato = new CD_Ubicacion();

        public List<Provincia> ObtenerProvincia() {

            return objCapaDato.ObtenerProvincia();
        
        }


        public List<Canton> ObtenerCanton(string IdProvincia) {
           
            return objCapaDato.ObtenerCanton(IdProvincia);

        }

        public List<Distrito> ObtenerDistrito(string IdCanton, string IdProvincia) {

            return objCapaDato.ObtenerDistrito(IdCanton,IdProvincia);

        }

    }
}
