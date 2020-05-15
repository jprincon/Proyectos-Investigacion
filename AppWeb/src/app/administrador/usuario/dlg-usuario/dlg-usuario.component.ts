import { Component, OnInit, Inject } from '@angular/core';
import { Utilidades } from '../../../Utilidades/utilidades.class';
import { SnackbarComponent } from '../../../dialogos/snackbar/snackbar.component';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ServiciosService } from '../../../Servicios/servicios.service';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Usuario, Rol } from '../../../Interfaces/interfaces.interface';
import { Md5 } from 'ts-md5/dist/md5';

@Component({
  selector: 'app-dlg-usuario',
  templateUrl: './dlg-usuario.component.html',
  styles: []
})
export class DlgUsuarioComponent implements OnInit {


usuario: Usuario = {
  nombre: '',
  correo: '',
  contra: '',
  idrol: ''
};

Roles: Rol[] = [];

accion: string;
id: string;
contIntentos = 0;
guardando = false;
leyendo = false;

constructor(public dialogRef: MatDialogRef<DlgUsuarioComponent>,
            @Inject(MAT_DIALOG_DATA) public data: any,
            private genService: ServiciosService,
            private snackBar: MatSnackBar) { }

ngOnInit() {
  this.accion = this.data.accion;
  this.id = this.data.idusuario;

  this.leerRoles();


  if (this.accion === 'Editar') {
    this.leerUsuario();
  }
}

leerRoles() {
  this.genService.getRoles().subscribe((rRoles: any) => {
    this.Roles = rRoles.Roles;
  });
}

leerUsuario() {
    this.genService.getUsuario(this.id).subscribe((rUsuario: Usuario) => {
      this.usuario = rUsuario;
    }, error => {
       this.leerUsuario();
    });
}

guardarUsuario() {

  this.guardando = true;

  if (this.accion === 'Crear') {

    const password = new Md5().appendStr(this.usuario.contra).end().toString();
    this.usuario.contra = password;

    console.log(this.usuario);
    const datos = JSON.stringify(this.usuario);
    this.genService.postUsuario(datos).subscribe((rRespuesta: any) => {
      console.log(rRespuesta);
      return this.dialogRef.close(rRespuesta.Respuesta || rRespuesta.Error);
    }, error => {

       this.guardarUsuario();
    });
  } else {
    const password = new Md5().appendStr(this.usuario.contra).end().toString();
    this.usuario.contra = password;

    const datos = JSON.stringify(this.usuario);

    this.genService.putUsuario(datos).subscribe((rRespuesta: any) => {
      console.log(rRespuesta);
      return this.dialogRef.close(rRespuesta.Respuesta || rRespuesta.Error);
    }, error => {

       this.guardarUsuario();
    });
  }
}
mostrarSnackBar(titulo: string, msg: string) {
  this.snackBar.openFromComponent(SnackbarComponent, {
    data: {Titulo: titulo, Mensaje: msg}, duration: 5000
  });
}

}
