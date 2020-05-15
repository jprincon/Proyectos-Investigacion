import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';
import { ServiciosService } from './servicios.service';

@Injectable({
  providedIn: 'root'
})
export class TransferenciaService {

  /* MÉTODO PARA ACTUALIZAR Y OBTENER EL USUARIO EN TODA LA APLICACIÓN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% */
  private bsUsuario = new BehaviorSubject<any>({});
  public obtenerUsuario = this.bsUsuario.asObservable();

  constructor(private servicio: ServiciosService) { }

  actualizarUsuario(usuario: any) {
    this.bsUsuario.next(usuario);
  }
}
