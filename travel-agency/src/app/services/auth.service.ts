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
export class AuthService {

  private gatewayUrl = environment.gatewayUrlConst;
  private appName = environment.appName;
  userSignedIn$: Subject<boolean> = new Subject();
  constructor(
    private authTokenService: AngularTokenService,
    private http: HttpClient, 
    private router: Router) {
    this.authTokenService.validateToken().subscribe(
      res => res.status == 200 ? this.userSignedIn$.next(res.json().success) : this.userSignedIn$.next(false)
    );
   }

    registerUser(signUpData:{
      login: string, 
      name: string, 
      password: string, 
      passwordConfirmation: string}): Observable<Response> {
      return this.authTokenService.registerAccount(signUpData).pipe(
        map(res => {
          this.userSignedIn$.next(true);
          return res;
        })
    );      
  }

  getVersionNumber(){
    return this.http.get(this.gatewayUrl+'/versions?app_name='+this.appName).pipe(
      map(res => {
        return res;
      })
    );
  }

}
