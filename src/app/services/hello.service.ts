import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

//const API_URL = 'http://localhost:8080/api/v1/hello';
//const API_URL = 'http://hostingtest-24-backend-cic-controlbook-dev.cic-openshift-cluster-84d63e86d4736aa154ba7e293148b17a-0000.eu-de.containers.appdomain.cloud/api/v1/hello';
const API_URL = "/api/v1/hello";

@Injectable({
  providedIn: 'root',
})
export class HelloService {
  constructor(private http: HttpClient) {}
  

  getServerMessage(): Observable<any> {
    return this.http.get("/asdf/qwer" , { responseType: 'text' });
  }
  
}
