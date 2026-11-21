class Tramite {
  var demoraBase

  method demoraTotal() = demoraBase + self.demoraExtra()

  method demoraExtra()

  method estaCajoneado() = self.demoraTotal() > 30

  method aumentarDemoraBase(dias) {
    demoraBase += dias
  }
}

class RenovacionDNI inherits Tramite {
  const hayFeriadoLargo

  override method demoraExtra() = if(hayFeriadoLargo) 5 else 2
}

object licenciaDeConducir inherits Tramite(demoraBase=10) {
  const inspectores = #{"el Tano Ferraro", "la seniora Norma del tercer piso"}

  override method demoraExtra() = 3 * self.cantidadInspectores()

  method cantidadInspectores() = inspectores.size()
}

class TramiteCombinado inherits Tramite {
  const subTramites = #{}

  override method demoraExtra() = (subTramites.map({tramite => tramite.demoraExtra()})).max()
}

class Puesto {
  method validarTramite(tramite, empleado)
  method puedeTomarReclamoInmediatamente(reclamo)
}

class Reclamo {
  const texto
  const fechaIngreso
  var fechaLimite

  method incluyePalabra(palabra) = texto.contains(palabra)

  method extenderFechaLimite(meses) {
    fechaLimite = fechaLimite.plusMonths(meses)
  }

  method tieneDiasDeAntiguedad(cantidadDias) = (fechaLimite - fechaIngreso) > cantidadDias
}

object ventanilla inherits Puesto {
  const palabrasClave = #{"urgente", "jubilado", "discapacidad"}

  override method validarTramite(tramite, empleado) {
    if(tramite.demoraTotal() > empleado.paciencia()) throw new DomainException(message="La demora total del tramite supera la paciencia del empleado")
  }

  override method puedeTomarReclamoInmediatamente(reclamo) = palabrasClave.any({palabra => reclamo.incluyePalabra(palabra)})
}

object jefeDeSeccion inherits Puesto {
  override method validarTramite(tramite, empleado) {
    if(empleado.cantidadDeTramitesEnCurso() >= 5) throw new DomainException(message="Un jefe de seccion no puede tener 5 o mas tramites en curso")
  }
  
  override method puedeTomarReclamoInmediatamente(reclamo) = reclamo.tieneDiasDeAntiguedad(30)
}

class EmpleadoPublico {
  var puesto
  const property paciencia
  const tramitesEnCurso = #{}
  const energia
  const bandejaDePendientes = #{}

  method cantidadDeTramitesEnCurso() = tramitesEnCurso.size()

  method recibirReclamo(reclamo) {
    if(not puesto.puedeTomarReclamoInmediatamente(reclamo)) reclamo.extenderFechaLimite(6)

    bandejaDePendientes.add(reclamo)
  }

  method tomarTramite(tramite) {
    self.validarEnergia()
    puesto.validarTramite(tramite, self)

    tramitesEnCurso.add(tramite)
  }

  method validarEnergia() {
    if(energia <= 0) throw new DomainException(message="No es posible tomar un tramite sin energia")
  }

  method tramitesCajoneados() = tramitesEnCurso.filter({tramite => tramite.estaCajoneado()})

  method iniciarParo() {
    tramitesEnCurso.forEach({tramite => tramite.aumentarDemoraBase(2)})
  }

  method cambiarDePuesto(nuevoPuesto) {
    puesto = nuevoPuesto
  }
}