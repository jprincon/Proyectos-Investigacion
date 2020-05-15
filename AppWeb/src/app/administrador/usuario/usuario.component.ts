import { Component, OnInit } from '@angular/core';
import { Usuario, Rol } from '../../Interfaces/interfaces.interface';
import { ServiciosService } from '../../Servicios/servicios.service';
import { DialogService } from '../../Servicios/dialog.service';

@Component({
  selector: 'app-usuario',
  templateUrl: './usuario.component.html',
  styles: []
})
export class UsuarioComponent implements OnInit {

  Usuarios: Usuario[] = [];
  leyendo = false;
  contIntentos = 1;

  Roles: Rol[] = [];

  constructor(private genService: ServiciosService,
              private dlgService: DialogService) { }

  ngOnInit() {
    this.leerUsuarios();
  }

  leerUsuarios() {

    this.leyendo = true;

    this.genService.getUsuarios().subscribe((rUsuarios: any) => {
      this.Usuarios = rUsuarios.Usuarios;
      console.log(rUsuarios);
      this.leyendo = false;
    }, error => {
       this.leerUsuarios();
    });
  }

  agregarUsuario() {
    this.dlgService.DlgUsuario('Crear', '').subscribe((rRespuesta: any) => {
      console.log(rRespuesta);
      this.leerUsuarios();
    });
  }

  editarUsuario(usuario: Usuario) {
    this.dlgService.DlgUsuario('Editar', usuario.idusuario).subscribe((rRespuesta: any) => {
      console.log(rRespuesta);
      this.leerUsuarios();
    });
  }

  eliminarUsuario(usuario: Usuario) {
    this.dlgService.confirmacion('¿Está seguro de eliminar este Usuario?').subscribe((rConfirmacion: any) => {
      console.log(rConfirmacion);
      if (rConfirmacion) {
        this.borrarUsuario(usuario.idusuario);
      }
    });
  }

  borrarUsuario(id: string) {
    this.genService.deleteUsuario(id).subscribe((rRespuesta: any) => {
      console.log(rRespuesta);
      this.dlgService.mostrarSnackBar('Información', rRespuesta.Respuesta || rRespuesta.Error);
      this.leerUsuarios();
    }, error => {
       this.borrarUsuario(id);
    });
  }

}
