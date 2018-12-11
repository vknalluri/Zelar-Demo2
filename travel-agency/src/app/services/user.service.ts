import { Injectable } from '@angular/core';
import { HttpClientModule, HttpClient, HttpRequest, HttpHandler, HttpEvent, HttpInterceptor } from '@angular/common/http';
import { AngularTokenService } from 'angular-token';
import { Observable, Subject} from 'rxjs';
import { map } from 'rxjs/operators';
import { Router } from '@angular/router';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  private gatewayUrl = environment.gatewayUrlConst;
  
  userSignedIn$: Subject<boolean> = new Subject();
  constructor(
    private authTokenService: AngularTokenService,
    private http: HttpClient, 
    private router: Router) {
    this.authTokenService.validateToken().subscribe(
      res => res.status == 200 ? this.userSignedIn$.next(res.json().success) : this.userSignedIn$.next(false)
    );
   }

  getUsers(){
    return this.http.get(this.gatewayUrl + '/requests?path=/devise_users&service=auth').pipe(
      map(res => {
        return res;
      })
    );
  }
}
