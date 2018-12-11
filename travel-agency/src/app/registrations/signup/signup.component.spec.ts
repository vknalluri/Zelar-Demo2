// import 'zone.js/dist/long-stack-trace-zone.js';
// import 'zone.js/dist/async-test.js';
// import 'zone.js/dist/fake-async-test.js';
// import 'zone.js/dist/sync-test.js';
// import 'zone.js/dist/proxy.js';
//import 'zone.js/dist/jasmine-patch.js';

import {ComponentFixture, TestBed } from '@angular/core/testing';

import { SignupComponent } from './signup.component';

import { BrowserDynamicTestingModule,
  platformBrowserDynamicTesting } from '@angular/platform-browser-dynamic/testing';

  
describe('SignupComponent', () => {
  let component: SignupComponent;
  let fixture: ComponentFixture<SignupComponent>;

  // beforeAll( ()=> {
  //   TestBed.initTestEnvironment(BrowserDynamicTestingModule, platformBrowserDynamicTesting());
  // });

  // afterEach(()=>{
  //   TestBed.resetTestEnvironment();
  // });

  beforeEach(() => {
    TestBed.resetTestEnvironment();
    TestBed.initTestEnvironment(BrowserDynamicTestingModule, platformBrowserDynamicTesting());
    TestBed.configureTestingModule({
      declarations: [ SignupComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    TestBed.resetTestEnvironment();
    TestBed.initTestEnvironment(BrowserDynamicTestingModule, platformBrowserDynamicTesting());
    fixture = TestBed.createComponent(SignupComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it(`should have as title 'Mars Travel, Inc'`, () => {
    const fixture = TestBed.createComponent(SignupComponent);
    const app = fixture.debugElement.componentInstance;
    expect(app.title).toEqual('Mars Travel, Inc');
  });

  it('should render title in a h1 tag', () => {
    const fixture = TestBed.createComponent(SignupComponent);
    fixture.detectChanges();
    const compiled = fixture.debugElement.nativeElement;
    expect(compiled.querySelector('h1').textContent).toContain('Welcome to Mars Travel, Inc!');
  });
});
