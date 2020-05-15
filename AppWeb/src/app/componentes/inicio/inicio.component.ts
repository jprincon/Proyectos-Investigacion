import { Component, OnInit } from '@angular/core';
import { Usuario } from 'src/app/Interfaces/interfaces.interface';
import { ServiciosService } from '../../Servicios/servicios.service';
import { Md5 } from 'ts-md5/dist/md5';
import { DialogService } from '../../Servicios/dialog.service';
import { RUTA_MENU_PRINCIPAL } from '../../config/constantes';

@Component({
  selector: 'app-inicio',
  templateUrl: './inicio.component.html',
  styles: []
})
export class InicioComponent implements OnInit {

  usuario: Usuario = {
    idusuario: '',
    contra: ''
  };

  constructor(private genService: ServiciosService,
              private dlgService: DialogService) { }

  ngOnInit() {
  }

  iniciarSesion() {
    this.genService.getUsuario(this.usuario.idusuario).subscribe((rUsuario: any) => {
      console.log(rUsuario);

      const password = new Md5().appendStr(this.usuario.contra).end().toString();

      // %%%%%%% Verificar si el usuario existe %%%%%%%
      if (rUsuario.Respuesta === 'Consulta con resultado vacio') {
        this.dlgService.mostrarSnackBar('Error', 'El usuario no esta registrado');
        return;
      }

      // %%%%%%% Verificar si las contraseñas son incorrectas %%%%%%%
      if (password !== rUsuario.contra) {
        this.dlgService.mostrarSnackBar('Error', 'La contraseña es incorrecta');
        return;
      } else {
        // %%%%%%% Pasa la prueba de las contraselas %%%%%%%
        this.dlgService.mostrarSnackBar('Información', rUsuario.nombre+', bienvenid@ a Proyectos de Investigación');
        this.genService.navegar([RUTA_MENU_PRINCIPAL]);
      }



    });
  }

}
