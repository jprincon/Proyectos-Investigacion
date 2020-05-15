import { Injectable } from '@angular/core';
import { CanActivate } from '@angular/router/src/utils/preactivation';
import { ActivatedRouteSnapshot, Router, RouterStateSnapshot } from '@angular/router';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthGuardService implements CanActivate {

  path: ActivatedRouteSnapshot[];
  route: ActivatedRouteSnapshot;

  puedeVerRuta = true;

  constructor(private router: Router) {

    if (!this.puedeVerRuta) {
      this.router.navigate(['inicio']);
    }
  }

  canActivate(): boolean {

    return this.puedeVerRuta;
  }
}
