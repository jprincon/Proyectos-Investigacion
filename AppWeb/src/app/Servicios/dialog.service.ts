import { Injectable } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { DlgRolComponent } from '../administrador/rol/dlg-rol/dlg-rol.component';
import { SnackbarComponent } from '../dialogos/snackbar/snackbar.component';
import { ConfirmacionComponent } from '../dialogos/confirmacion/confirmacion.component';
import { DlgUsuarioComponent } from '../administrador/usuario/dlg-usuario/dlg-usuario.component';

@Injectable({
  providedIn: 'root'
})
export class DialogService {

  constructor(public dialog: MatDialog,
              private snackBar: MatSnackBar) { }

  confirmacion(msg: string) {
    const dialogRef = this.dialog.open(ConfirmacionComponent, {
      width: '60%',
      data: {Msg: msg}
    });

    return dialogRef.afterClosed();
  }

  mostrarSnackBar(titulo: string, msg: string) {
    this.snackBar.openFromComponent(SnackbarComponent, {
      data: {Titulo: titulo, Mensaje: msg}, duration: 5000
    });
  }

  DlgRol(sAccion: string, id: string) {
    const dialogRef = this.dialog.open(DlgRolComponent, {
      width: '60%',
      data: {accion: sAccion, idrol: id}
    });

    return dialogRef.afterClosed();
  }

  DlgUsuario(sAccion: string, id: string) {
    const dialogRef = this.dialog.open(DlgUsuarioComponent, {
      width: '60%',
      data: {accion: sAccion, idusuario: id}
    });

    return dialogRef.afterClosed();
  }


}
