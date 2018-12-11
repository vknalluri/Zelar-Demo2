import { Component, OnInit,Output, EventEmitter  } from '@angular/core';
import { AuthService } from '../../services/auth.service';
import { Router } from '@angular/router';


@Component({
  selector: 'app-signup',
  templateUrl: './signup.component.html',
  styleUrls: ['./signup.component.css', '../../app.component.css']
})
export class SignupComponent implements OnInit {

  constructor(
    private authService:AuthService, 
    private router:Router
  ) { }

  ngOnInit() {
    this.versionNumber();
  }

  static_password = "test1234"

  title = 'Mars Travel, Inc';
  signUpUser = {
    login: '',
    email: '',
    name: '',
    password: this.static_password,
    passwordConfirmation: this.static_password
  };

  signUpErrors = [];
  displaySuccessAlert = false;
  displayErrorAlert = false;
  version_number: any = null;

  @Output() onFormResult = new EventEmitter<any>();


  onSignUpSubmit(){
    this.authService.registerUser(this.signUpUser).subscribe(
        res => {
          console.log(res);
          if(res.status.toString() === "success"){
            this.onFormResult.emit({signedIn: true, res});
            this.displaySuccessAlert=true;
            this.displayErrorAlert=false;
            this.router.navigate(['/']);
            
          }
        },
        e => {
          this.emptyErrors()
          this.signUpErrors.push(e.error.errors.full_messages);
          this.onFormResult.emit({signedIn: false, e});
          this.displaySuccessAlert=false;
          this.displayErrorAlert=true;          
        }
    );
  };
  
  closeAlert(){
    this.displaySuccessAlert = false;
    this.displayErrorAlert = false;
    this.emptyErrors()
  }

  emptyErrors(){
    this.signUpErrors.length = 0
  }

  versionNumber(){
    this.authService.getVersionNumber().subscribe(
      res => {
        this.version_number = res;
      },
      e => {
        console.log(e)  
      }
    );
  }

}
