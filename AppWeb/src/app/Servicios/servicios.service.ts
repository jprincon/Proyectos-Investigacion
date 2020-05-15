import { Injectable } from '@angular/core';
import { HttpHeaders, HttpClient } from '@angular/common/http';
import { Md5 } from 'ts-md5/dist/md5';
import { retry } from "rxjs/operators";
import { Router } from '@angular/router';
import { LS_ULTIMA_RUTA, RUTA_INICIO } from '../config/constantes';

@Injectable({
  providedIn: 'root'
})
export class ServiciosService {

  letras: string[] = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r',
                      's', 't', 'u', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

  private token = '';
  private ENCABEZADO_HTTP = 'http://';
  private IP_SERVIDOR = '201.185.240.142';
  private PUERTO = ':1700';
  private GENERAL = '/datasnap/rest/tinvestigacion/';

  private URL_TOKEN = 'token';

  private URL_ROL = 'Rol';
  private URL_ROLES = 'Roles';
  private URL_USUARIO = 'Usuario';
  private URL_USUARIOS = 'Usuarios';


  constructor(private http: HttpClient,
              private router: Router) {

    this.postToken().subscribe((respuesta: any) => {
      this.token = respuesta.token;
      // console.log(respuesta);
    });
  }

  generarID() {

    let id = '';

    for (let i = 1; i < 9; i++) {
      const posicion = Math.round(Math.random() * (this.letras.length - 1));
      id = id + this.letras[posicion];
    }

    id = id + '-';

    for (let i = 1; i < 5; i++) {
      const posicion = Math.round(Math.random() * (this.letras.length - 1));
      id = id + this.letras[posicion];
    }

    id = id + '-';

    for (let i = 1; i < 5; i++) {
      const posicion = Math.round(Math.random() * (this.letras.length - 1));
      id = id + this.letras[posicion];
    }

    id = id + '-';

    for (let i = 1; i < 13; i++) {
      const posicion = Math.round(Math.random() * (this.letras.length - 1));
      id = id + this.letras[posicion];
    }

    return id;
  }

  // Rutas del Servidor %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  dataSnap_Path(ruta: string) {
    return this.ENCABEZADO_HTTP + this.IP_SERVIDOR + this.PUERTO + this.GENERAL + ruta;
  }

  parametro(dato: string) {
    return '/' + dato;
  }

  postToken() {
    const url = this.dataSnap_Path(this.URL_TOKEN);
    const headers = new HttpHeaders({
      'Content-Type': 'application/json'
    });

    const credenciales = {
      nombre: 'jprincon',
      correo: 'jarincon@uniquindio.edu.co',
      clave: 'Donmatematicas#512519'
    };

    const datos = JSON.stringify(credenciales);

    return this.http.post(url, datos, {headers});
  }

  navegar(ruta: string[]) {
    const rutas = {
      Rutas: ruta
    };

    localStorage.setItem(LS_ULTIMA_RUTA, JSON.stringify(rutas));
    this.router.navigate(ruta);
}

restaurarRuta() {
   if (!localStorage.getItem(LS_ULTIMA_RUTA)) {
    this.navegar([RUTA_INICIO]);
    return;
   }

   this.navegar(JSON.parse(localStorage.getItem(LS_ULTIMA_RUTA).toString()).Rutas);
}

  /* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     MÉTODOS PARA EL SERVICIO DE ROLES
  =========================================================================================================================*/
  postRol(datos: string) {
    const url = this.dataSnap_Path(this.URL_ROL) + this.parametro(this.token);
    const headers = new HttpHeaders({
      'Content-Type': 'application/json'
    });
    return this.http.post(url, datos, {headers}).pipe(retry());
  }

  getRoles() {
    const url = this.dataSnap_Path(this.URL_ROLES);
    return this.http.get(url).pipe(retry());
  }

  getRol(id: string) {
    const url = this.dataSnap_Path(this.URL_ROL) + this.parametro(id);
    return this.http.get(url).pipe(retry());
  }

  putRol(datos: string) {
    const url = this.dataSnap_Path(this.URL_ROL) + this.parametro(this.token);
    const headers = new HttpHeaders({
      'Content-Type': 'application/json'
    });
    return this.http.put(url, datos, {headers}).pipe(retry());
  }

  deleteRol(id: string) {
    const url = this.dataSnap_Path(this.URL_ROL) + this.parametro(this.token) + this.parametro(id);
    console.log(url);
    const headers = new HttpHeaders({
      'Content-Type': 'application/json'
    });
    return this.http.delete(url, {headers}).pipe(retry());
  }

  /* Usuario %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% */

  postUsuario(datos: string) {
    const url = this.dataSnap_Path(this.URL_USUARIO) + this.parametro(this.token);
    const headers = new HttpHeaders({
      'Content-Type': 'application/json'
    });
    return this.http.post(url, datos, {headers}).pipe(retry());
  }

  getUsuarios() {
    const url = this.dataSnap_Path(this.URL_USUARIOS);
    return this.http.get(url).pipe(retry());
  }

  getUsuario(id: string) {
    const url = this.dataSnap_Path(this.URL_USUARIO) + this.parametro(id);
    return this.http.get(url).pipe(retry());
  }

  putUsuario(datos: string) {
    const url = this.dataSnap_Path(this.URL_USUARIO) + this.parametro(this.token);
    const headers = new HttpHeaders({
      'Content-Type': 'application/json'
    });
    return this.http.put(url, datos, {headers}).pipe(retry());
  }

  deleteUsuario(id: string) {
    const url = this.dataSnap_Path(this.URL_USUARIO) + this.parametro(this.token) + this.parametro(id);
    console.log(url);
    const headers = new HttpHeaders({
      'Content-Type': 'application/json'
    });
    return this.http.delete(url, {headers}).pipe(retry());
  }

}
