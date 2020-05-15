import { Component, OnInit } from '@angular/core';
import { Rol } from '../../Interfaces/interfaces.interface';
import { ServiciosService } from '../../Servicios/servicios.service';
import { DialogService } from '../../Servicios/dialog.service';

@Component({
  selector: 'app-rol',
  templateUrl: './rol.component.html',
  styles: []
})
export class RolComponent implements OnInit {

  Roles: Rol[] = [];
  leyendo = false;
  contIntentos = 1;

  constructor(private genService: ServiciosService,
              private dlgService: DialogService) { }

  ngOnInit() {
    this.leerRoles();
  }

  leerRoles() {

    this.leyendo = true;

    this.genService.getRoles().subscribe((rRoles: any) => {
      this.Roles = rRoles.Roles;
      // console.log(rRoles);
      this.leyendo = false;
    });
  }

  agregarRol() {
    this.dlgService.DlgRol('Crear', '').subscribe((rRespuesta: any) => {
      console.log(rRespuesta);
      this.leerRoles();
    });
  }

  editarRol(rol: Rol) {
    this.dlgService.DlgRol('Editar', rol.idrol).subscribe((rRespuesta: any) => {
      console.log(rRespuesta);
      this.leerRoles();
    });
  }

  eliminarRol(rol: Rol) {
    this.dlgService.confirmacion('¿Está seguro de eliminar este Rol?').subscribe((rConfirmacion: any) => {
      console.log(rConfirmacion);
      if (rConfirmacion) {
        this.borrarRol(rol.idrol);
      }
    });
  }

  borrarRol(id: string) {
    this.genService.deleteRol(id).subscribe((rRespuesta: any) => {
      console.log(rRespuesta);
      this.dlgService.mostrarSnackBar('Información', rRespuesta.Respuesta || rRespuesta.Error);
      this.leerRoles();
    }, error => {
       this.borrarRol(id);
    });
  }

}
