import { Component, OnInit, Inject } from '@angular/core';
import { Utilidades } from '../../../Utilidades/utilidades.class';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ServiciosService } from '../../../Servicios/servicios.service';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Rol } from '../../../Interfaces/interfaces.interface';
import { SnackbarComponent } from '../../../dialogos/snackbar/snackbar.component';

@Component({
  selector: 'app-dlg-rol',
  templateUrl: './dlg-rol.component.html',
  styles: []
})
export class DlgRolComponent implements OnInit {


rol: Rol = {
  rol: ''
};

accion: string;
id: string;
contIntentos = 0;
guardando = false;
leyendo = false;

constructor(public dialogRef: MatDialogRef<DlgRolComponent>,
            @Inject(MAT_DIALOG_DATA) public data: any,
            private genService: ServiciosService,
            private snackBar: MatSnackBar) { }

ngOnInit() {
  this.accion = this.data.accion;
  this.id = this.data.idrol;


  if (this.accion === 'Editar') {
    this.leerRol();
  }
}

leerRol() {
    this.genService.getRol(this.id).subscribe((rRol: Rol) => {
      this.rol = rRol;
    }, error => {
       this.leerRol();
    });
}

guardarRol() {

  this.guardando = true;

  if (this.accion === 'Crear') {

    this.rol.idrol = new Utilidades().generarId();
    console.log(this.rol);
    const datos = JSON.stringify(this.rol);
    this.genService.postRol(datos).subscribe((rRespuesta: any) => {
      console.log(rRespuesta);
      return this.dialogRef.close(rRespuesta.Respuesta || rRespuesta.Error);
    }, error => {

       this.guardarRol();
    });
  } else {
    const datos = JSON.stringify(this.rol);

    this.genService.putRol(datos).subscribe((rRespuesta: any) => {
      console.log(rRespuesta);
      return this.dialogRef.close(rRespuesta.Respuesta || rRespuesta.Error);
    }, error => {

       this.guardarRol();
    });
  }
}
mostrarSnackBar(titulo: string, msg: string) {
  this.snackBar.openFromComponent(SnackbarComponent, {
    data: {Titulo: titulo, Mensaje: msg}, duration: 5000
  });
}

}
