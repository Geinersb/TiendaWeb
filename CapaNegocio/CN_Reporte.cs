using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaDatos;
using CapaEntidad;

namespace CapaNegocio
{
    public class CN_Reporte
    {
        private CD_Reporte objCapaDato = new CD_Reporte();

        public List<Reporte> Ventas(string FechaInicio, string FechaFin, string IdTransaccion)
        {
            return objCapaDato.Ventas(FechaInicio,FechaFin,IdTransaccion);

        }


        public Dashboard VerDashboard()
        {
            return objCapaDato.VerDashboard();
        }

    }
}
